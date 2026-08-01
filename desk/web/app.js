const { Urbit } = window.UrbitHttpApi;
const api = new Urbit("");
api.ship = window.ship;

const app = document.querySelector("#app");
const nav = document.querySelector("#nav");
const icon = document.querySelector("#sindi-icon");
const favicon = document.querySelector("#favicon");
const state = { items: [], urls: [] };

const esc = (value) => String(value ?? "").replace(/[&<>'"]/g, (char) => ({
  "&": "&amp;", "<": "&lt;", ">": "&gt;", "'": "&#39;", '"': "&quot;",
})[char]);

const hostname = (url) => {
  try { return new URL(url).hostname.replace(/^www\./, ""); }
  catch { return url; }
};

const displayUrl = (url) => String(url).replace(/^https?:\/\//, "").replace(/^www\./, "").replace(/\/$/, "");
const sourceUrl = (url) => {
  try { const parsed = new URL(url); return `${parsed.protocol}//${parsed.hostname}`; }
  catch { return url; }
};

async function poke(json) {
  try {
    await api.poke({ app: "sindi", mark: "sindi-action", json });
  } catch (error) {
    console.error(error);
    throw error;
  }
}

function renderItems(items = state.items) {
  if (!items.length) {
    const host = esc(window.location.hostname.replace(/^www\./, ""));
    const mobile = /android|iphone|ipad|ipod/i.test(navigator.userAgent) ||
      (navigator.maxTouchPoints > 1 && /macintosh/i.test(navigator.userAgent));

    // macos: dock
    // ios / ipados: homescreen
    // windows / linux: taskbar
    const shelf = mobile ? "homescreen" : /mac/i.test(navigator.userAgent) ? "dock" : "taskbar";

    app.innerHTML = `<article><ul id="news" class="empty">
      <li><span>This is Sindi, an RSS headline aggregator</span> <em>${host}</em></li>
      <li><span>It refreshes every fifteen minutes, if at all</span> <em>${host}</em></li>
      <li><span>Click “Feeds” to add feeds</span> <em>${host}</em></li>
      <li><span>Click the icon to see headlines</span> <em>${host}</em></li>
      <li><span>Save it to your ${shelf} and check in later</span> <em>${host}</em></li>
    </ul></article>`;
    return;
  }

  const sorted = [...items].sort((a, b) => Number(b.published) - Number(a.published));
  let day = "";
  const rows = sorted.map((item) => {
    const date = new Date(Number(item.published) * 1000);
    const key = `${date.getFullYear()}-${date.getMonth()}-${date.getDate()}`;
    let heading = "";
    if (key !== day) {
      day = key;
      const today = new Date();
      const sameDay = key === `${today.getFullYear()}-${today.getMonth()}-${today.getDate()}`;
      const sameYear = date.getFullYear() === today.getFullYear();
      const label = date.toLocaleDateString(undefined, {
        day: "numeric", month: "long", ...(sameYear ? {} : { year: "numeric" }),
      });
      heading = `<h3>${sameDay ? "Today, " : ""}${esc(label)}</h3>`;
    }
    return `<li>${heading}<a class="item-link${item.read ? " read" : ""}" href="${esc(item.url)}"
      target="_blank" rel="noopener noreferrer" data-mark-read="${esc(item.url)}">
      <span>${esc(item.title)}</span></a>
      <a class="source" href="${esc(sourceUrl(item.source))}" target="_blank"
      rel="noopener noreferrer" data-mark-read="${esc(item.url)}"><em>${esc(hostname(item.source))}</em></a></li>`;
  }).join("");
  app.innerHTML = `<article><ul id="news">${rows}</ul></article>`;
}

function renderFeeds() {
  const feeds = [...state.urls]
    .sort((a, b) => displayUrl(a).localeCompare(displayUrl(b), undefined, { sensitivity: "base" }))
    .map((url) => `<li><a data-feed="${esc(url)}" href="/apps/sindi?feed=${encodeURIComponent(url)}"><span>${esc(displayUrl(url))}</span></a>
    <button class="remove" type="button" data-remove="${esc(url)}"> remove</button></li>`).join("");
  app.innerHTML = `<div><section id="add-feed"><form id="add-feed-form">
    <button type="submit">Add </button><input name="urls" type="text" placeholder="links" autocomplete="url">
    </form></section><section id="feeds-section"><ul id="feeds">${feeds}</ul></section></div>`;
}

function render() {
  if (window.location.pathname.replace(/\/$/, "") === "/apps/sindi/feeds") return renderFeeds();
  const feed = new URLSearchParams(window.location.search).get("feed");
  if (feed) return renderItems(state.items.filter((item) => item.source === feed));
  renderItems();
}

nav.addEventListener("click", (event) => {
  const link = event.target.closest("a[href]");
  if (!link || event.defaultPrevented || event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
  const target = new URL(link.href, window.location.href);
  const route = target.pathname.replace(/\/$/, "");
  if (target.origin !== window.location.origin || (route !== "/apps/sindi" && route !== "/apps/sindi/feeds")) return;
  event.preventDefault();
  if (target.pathname + target.search !== window.location.pathname + window.location.search) {
    history.pushState({}, "", target.pathname + target.search);
  }
  render();
  window.scrollTo({ top: 0, behavior: "auto" });
});

window.addEventListener("popstate", render);

app.addEventListener("submit", async (event) => {
  if (event.target.id !== "add-feed-form") return;
  event.preventDefault();
  const links = new FormData(event.target).get("urls").trim().split(/\s+/).filter(Boolean);
  if (!links.length) return;
  await poke({ "add-feeds": { links } });
  event.target.reset();
});

app.addEventListener("click", async (event) => {
  const remove = event.target.closest("[data-remove]");
  if (remove) {
    await poke({ "del-feed": { link: remove.dataset.remove } });
    return;
  }
  const feed = event.target.closest("[data-feed]");
  if (feed) {
    event.preventDefault();
    const target = `/apps/sindi?feed=${encodeURIComponent(feed.dataset.feed)}`;
    if (target !== window.location.pathname + window.location.search) history.pushState({}, "", target);
    render();
    window.scrollTo({ top: 0, behavior: "auto" });
    return;
  }
  const read = event.target.closest("[data-mark-read]");
  if (read) {
    const link = read.dataset.markRead;
    const previousItems = state.items;
    state.items = state.items.map((item) => item.url === link ? { ...item, read: true } : item);
    renderItems();
    poke({ "mark-read": { link } }).catch(() => {
      state.items = previousItems;
      renderItems();
    });
  }
});

function subscribeLive(path, event) {
  const retry = () => window.setTimeout(() => subscribeLive(path, event), 500);
  api.subscribe({ app: "sindi", path, event, err: retry, quit: retry });
}

async function start() {
  try {
    [state.items, state.urls] = await Promise.all([
      api.scry({ app: "sindi", path: "/sindi/items" }),
      api.scry({ app: "sindi", path: "/sindi/urls" }),
    ]);
    render();
    subscribeLive("/x/sindi/items", (items) => { state.items = items; render(); });
    subscribeLive("/x/sindi/urls", (urls) => { state.urls = urls; render(); });
    subscribeLive("/x/sindi/icon", () => {
        const iconUrl = `/~/scry/sindi/sindi/icon.mime?${Date.now()}`;
        icon.src = iconUrl;
        favicon.href = iconUrl;
    });
  } catch (error) {
    console.error(error);
    app.innerHTML = '<section class="error"><h2>Could not load Sindi</h2><p>Refresh the page to try again.</p></section>';
  }
}

if ("serviceWorker" in navigator) navigator.serviceWorker.register("/apps/sindi/sw.js");
start();
