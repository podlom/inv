import { useTranslation as useI18nTranslation } from "react-i18next";
import type { SupportedLanguage } from "../types/i18n";

export const useTranslation = () => {
  const { t, i18n } = useI18nTranslation();

  const changeLanguage = (language: SupportedLanguage) => {
    i18n.changeLanguage(language);
    // Update document.documentElement.lang to reflect the change
    document.documentElement.lang = language;
  };

  const currentLanguage = i18n.language as SupportedLanguage;

  return {
    t,
    changeLanguage,
    currentLanguage,
    isReady: i18n.isInitialized,
  };
};
