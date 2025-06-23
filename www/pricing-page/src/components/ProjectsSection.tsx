import { Gallery } from "./blocks/gallery";
import { useTranslation } from "../hooks/useTranslation";
import {
  useProjects,
  mapApiProjectToProjectItem,
  type ApiProject,
} from "../hooks/useProjects";
import fallbackProjectsRaw from "../data/projects.json";

export const ProjectsSection = () => {
  const { t, currentLanguage } = useTranslation();
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

  return (
    <section id="projects" className="pb-24 pt-16">
      <Gallery
        title={t("gallery.projects.title")}
        type="projects"
        data={projectsError || !projects.length ? fallbackProjects : projects}
        showAllLink={getShowAllLink()}
        loading={projectsLoading}
      />
    </section>
  );
};
