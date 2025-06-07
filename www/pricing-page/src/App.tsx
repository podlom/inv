import "./App.css";
import PricingSection from "./components/PricingSection";

import { Gallery } from "./components/blocks/gallery";
import { Hero } from "./components/blocks/hero";
import { ReviewsSection } from "./components/ReviewsSection";
// import { LanguageSwitcher } from "./components/LanguageSwitcher";
import { useTranslation } from "./hooks/useTranslation";
import {
  useProjects,
  mapApiProjectToProjectItem,
  type ApiProject,
} from "./hooks/useProjects";
import fallbackProjectsRaw from "./data/projects.json";

function App() {
  const { t, isReady, currentLanguage } = useTranslation();
  const {
    projects,
    loading: projectsLoading,
    error: projectsError,
  } = useProjects();

  // Map fallback projects from raw API format to ProjectItem format
  const fallbackProjects = (fallbackProjectsRaw as ApiProject[]).map(
    (project) => mapApiProjectToProjectItem(project)
  );

  // Generate showAllLink based on current language
  const getShowAllLink = () => {
    switch (currentLanguage) {
      case "en":
        return "https://inventure.com.ua/en/investments";
      case "uk":
        return "https://inventure.com.ua/uk/investments";
      case "ru":
      default:
        return "https://inventure.com.ua/investments";
    }
  };

  if (!isReady) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-lg">{t("loading")}</div>
      </div>
    );
  }

  return (
    <div className="overflow-x-hidden">
      {/* Language Switcher - positioned at top right */}
      {/* <div className="fixed top-4 right-4 z-50">
        <LanguageSwitcher />
      </div> */}

      <Hero />
      <div id="pricing" className="pt-24 pb-16 container mx-auto">
        <PricingSection />
      </div>
      <div className="pb-24 pt-16">
        <Gallery
          title={t("gallery.projects.title")}
          type="projects"
          data={projectsError || !projects.length ? fallbackProjects : projects}
          showAllLink={getShowAllLink()}
          loading={projectsLoading}
        />
      </div>
      <ReviewsSection />
    </div>
  );
}

export default App;
