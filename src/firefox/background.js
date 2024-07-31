// background.js
chrome.webRequest.onBeforeRequest.addListener(
  function(details) {
    let url = new URL(details.url);

    // Check if the 'tag' parameter is already present to avoid loops
    if (!url.searchParams.has('tag')) {
      url.searchParams.set('tag', 'wwsiv-21');
      return { redirectUrl: url.toString() };
    }

    // If the 'tag' parameter is already present, do not redirect
    return { cancel: false };
  },
  { urls: ["*://*.amazon.com/*", "*://*.amazon.de/*", "*://*.amazon.co.uk/*", "*://*.amazon.fr/*", "*://*.amazon.it/*", "*://*.amazon.es/*"] },
  ["blocking"]
);
