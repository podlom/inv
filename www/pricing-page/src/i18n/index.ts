import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";

// Import translation files
import enTranslations from "./locales/en.json";
import ukTranslations from "./locales/uk.json";
import ruTranslations from "./locales/ru.json";

// Custom language detector that prioritizes document.documentElement.lang
const customLanguageDetector = {
  name: "customDetector",
  lookup() {
    // First check document.documentElement.lang
    const htmlLang = document.documentElement.lang;
    console.log({ htmlLang });
    if (htmlLang && ["en", "uk", "ru"].includes(htmlLang)) {
      return htmlLang;
    }

    // Fallback to browser language
    const browserLang = navigator.language.split("-")[0];
    console.log({ browserLang });
    if (["en", "uk", "ru"].includes(browserLang)) {
      return browserLang;
    }

    // Default fallback
    return "en";
  },
  cacheUserLanguage() {
    // Optional: implement caching logic if needed
  },
};

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources: {
      en: {
        translation: enTranslations,
      },
      uk: {
        translation: ukTranslations,
      },
      ru: {
        translation: ruTranslations,
      },
    },
    fallbackLng: "uk",
    supportedLngs: ["en", "uk", "ru"],

    detection: {
      order: ["htmlTag"],
      lookupFromPathIndex: 0,
      lookupFromSubdomainIndex: 0,
      caches: ["localStorage"],
    },

    interpolation: {
      escapeValue: false, // React already does escaping
    },

    react: {
      useSuspense: false,
    },
  });

// Add custom detector
i18n.services.languageDetector.addDetector(customLanguageDetector);

export default i18n;
