import React from "react";
import { Gallery } from "./blocks/gallery";
import { useTranslation } from "../hooks/useTranslation";
import {
  useProjects,
  mapApiProjectToProjectItem,
  type ApiProject,
} from "../hooks/useProjects";
import fallbackProjectsRaw from "../data/projects.json";

export const ProjectsSection = React.memo(() => {
  const { t, currentLanguage } = useTranslation();
  const {
    projects,
    loading: projectsLoading,
    loadingMore: projectsLoadingMore,
    error: projectsError,
    hasMore: projectsHasMore,
    loadMore: loadMoreProjects,
  } = useProjects({
    enablePagination: true,
  });

  // Memoize fallback projects mapping to prevent recreation on every render
  const fallbackProjects = React.useMemo(() => {
    return (fallbackProjectsRaw as ApiProject[]).map((project) =>
      mapApiProjectToProjectItem(project)
    );
  }, []);

  // Memoize data selection to prevent unnecessary rerenders
  const galleryData = React.useMemo(() => {
    return projectsError || !projects.length ? fallbackProjects : projects;
  }, [projectsError, projects, fallbackProjects]);

  // Memoize showAllLink generation based on current language
  const showAllLink = React.useMemo(() => {
    switch (currentLanguage) {
      case "en":
        return "https://inventure.com.ua/en/investments";
      case "uk":
        return "https://inventure.com.ua/uk/investments";
      case "ru":
      default:
        return "https://inventure.com.ua/investments";
    }
  }, [currentLanguage]);

  // Memoize gallery title to prevent translation recalculation
  const galleryTitle = React.useMemo(() => {
    return t("gallery.projects.title");
  }, [t]);

  return (
    <section id="projects" className="pb-24 pt-16">
      <Gallery
        title={galleryTitle}
        type="projects"
        data={galleryData}
        showAllLink={showAllLink}
        loading={projectsLoading}
        loadingMore={projectsLoadingMore}
        hasMore={projectsHasMore}
        onLoadMore={loadMoreProjects}
      />
    </section>
  );
});

ProjectsSection.displayName = "ProjectsSection";
