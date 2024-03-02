import { getRandomNumber, loadScript } from "./helpers";

const advertCard = `<a href="/add-inv-prop" class="cards__item project-0">
<div class="cards__img-wrapper mb-2 lang-ru is-sold-0">
  <img class="cards__img" src="/images/inventure-poster.jpg" alt="Найти инвестора, продать бизнес или коммерческую недвижимость, франчайзинг">
</div>
<div class="opacity-75 text-sm w-full cards__meta pt-0 mt-0">29.12.20</div>
<h2 class="cards__title mt-0" itemprop="headline">Найти инвестора, продать бизнес или коммерческую недвижимость, франчайзинг</h2>
<div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
      <div class=""></div>
      <div class="cards__meta-wrapper text-sm">
          <div class="cards__meta-stat">
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M13.9631 5.36967C13.871 5.08618 13.6195 4.88548 13.3232 4.85867L9.28184 4.49177L7.68466 0.752449C7.56674 0.477725 7.29842 0.300415 6.99977 0.300415C6.70112 0.300415 6.4327 0.477725 6.31553 0.752449L4.71835 4.49177L0.67632 4.85867C0.38002 4.88602 0.129115 5.08672 0.0364013 5.36967C-0.0557786 5.65315 0.0293516 5.96408 0.253446 6.16062L3.30841 8.83939L2.40766 12.8067C2.34175 13.0984 2.45498 13.4 2.69701 13.575C2.82711 13.6695 2.97996 13.7167 3.13335 13.7167C3.26515 13.7167 3.39707 13.6817 3.51488 13.6112L6.99977 11.5275L10.484 13.6112C10.7396 13.7639 11.061 13.7499 11.3025 13.575C11.5446 13.4 11.6578 13.0984 11.5919 12.8067L10.6911 8.83939L13.7461 6.16062C13.9701 5.96408 14.0553 5.65379 13.9631 5.36967Z" fill="#808080"/>
              </svg>
              <div>10</div>
          </div>
          <div class="cards__meta-stat">
              <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"/>
                      <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"/>
              </svg>
              <div>${getRandomNumber(700, 1200)}</div>
          </div>
      </div>
  </div>
</a>`;
function fetchData(search) {
  const limitQuery = "limit=23";
  const query = search
    ? `${search}&action=get&${limitQuery}`
    : `?action=get&${limitQuery}`;
  const link = `/invest.php${query}`;

  return fetch(link)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.text();
    })
    .catch((error) => {
      console.error("Fetch error:", error);
      throw error; // Rethrow the error for the caller to handle
    });
}

const renderInvestments = (data) => {
  const cardsList = document.querySelector("#cards__list");
  cardsList.innerHTML = data;
  setTimeout(() => {
    const randomIndex = getRandomNumber(7, 20);
    const elements = document.querySelectorAll("#cards__list a");
    const elementByIndex = elements && elements[randomIndex];
    if (elementByIndex) {
      elementByIndex.insertAdjacentHTML("afterend", advertCard);
    }
    if(typeof window.htmx !== 'undefined'){
      window.htmx.process(cardsList)
    }
  }, 0);
};

export const init = () => {
  const { search, pathname } = window.location;
  const isInvestmentsPage = pathname.indexOf("/investments") !== -1;
  if (!isInvestmentsPage) return;
  fetchData(search)
    .then(renderInvestments)
    // .then(() => {
    //   return loadScript("https://unpkg.com/htmx.org@1.9.10");
    // })
    .catch((error) => {
      // Handle errors here
      console.error("Error occurred:", error.message);
    });
};
