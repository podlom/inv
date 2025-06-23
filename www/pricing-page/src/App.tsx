import "./App.css";
import PricingSection from "./components/PricingSection";

import { Hero } from "./components/blocks/hero";
import { ProjectsSection } from "./components/ProjectsSection";
import { ReviewsSection } from "./components/ReviewsSection";
// import { LanguageSwitcher } from "./components/LanguageSwitcher";
import { useTranslation } from "./hooks/useTranslation";

function App() {
  const { t, isReady } = useTranslation();

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

      <PricingSection />

      <ProjectsSection />
      <ReviewsSection />
    </div>
  );
}

export default App;
