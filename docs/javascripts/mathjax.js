window.MathJax = {
  tex: {
    inlineMath: [["$", "$"], ["\\(", "\\)"]],
    displayMath: [["$$", "$$"], ["\\[", "\\]"]],
    processEscapes: true,
    processEnvironments: true,
  },
  options: {
    ignoreHtmlClass: "(^|\\s)no-mathjax(\\s|$)",
    processHtmlClass: "(^|\\s)arithmatex(\\s|$)",
  },
};
