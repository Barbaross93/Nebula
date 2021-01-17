(() => {
  const fs = require("fs");
  const confDir = "/home/barbarossa/.config/discocss";
  const cssFile = "/home/barbarossa/.config/discocss/custom.css";

  function reload(style) {
    style.innerHTML = fs.readFileSync(cssFile);
  }

  function inject({ document, window }) {
    window.addEventListener("load", () => {
      const style = document.createElement("style");
      reload(style);
      document.head.appendChild(style);

      fs.watch(confDir, {}, () => reload(style));
    });
  }

  inject(require("electron").webFrame.context);
})();
