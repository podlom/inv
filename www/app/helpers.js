export function getRandomNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}
export function loadScript(src) {
  return new Promise((resolve) => {
    const script = document.createElement("script");
    script.src = src;
    script.type = "text/javascript";
    script.async = true;
    script.onload = resolve;
    document.body.appendChild(script);
  });
}
