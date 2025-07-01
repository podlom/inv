import { useState, useEffect, useCallback, useMemo } from "react";
import type { ProjectItem } from "../components/blocks/gallery";
import { useTranslation } from "./useTranslation";

export interface ApiProject {
  id: number;
  h1: string;
  status: number;
  deleted: number;
  published: string;
  short_text: string;
  subpath: string;
  created: string;
  updated: string;
  attr: string;
  class: number;
  image_id: number;
  image_url: string;
  user_id: number;
  route_id: number;
  views_1: number;
  rating_2: number;
  parent_id: number;
}

interface UseProjectsOptions {
  baseUrl?: string;
  pageSize?: number;
  enablePagination?: boolean;
}

// Consolidated state interface
interface ProjectsState {
  projects: ProjectItem[];
  loading: boolean;
  loadingMore: boolean;
  error: string | null;
  hasMore: boolean;
  currentPage: number;
}

const formatDate = (dateString: string): string => {
  try {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, "0");
    const month = (date.getMonth() + 1).toString().padStart(2, "0");
    const year = date.getFullYear().toString().slice(-2);
    return `${day}.${month}.${year}`;
  } catch {
    return dateString;
  }
};

const extractPriceFromAttr = (attrString: string): string => {
  try {
    const attr = JSON.parse(attrString);
    if (attr.attr15) {
      const amount = parseInt(attr.attr15);
      return `$${amount.toLocaleString()}`;
    }
    return "$0";
  } catch {
    return "$0";
  }
};

export const mapApiProjectToProjectItem = (
  apiProject: ApiProject,
  baseUrl = "https://inventure.com.ua",
  language = ""
): ProjectItem => {
  const fullImageUrl = apiProject.image_url.startsWith("http")
    ? apiProject.image_url
    : `${baseUrl}${apiProject.image_url}`;

  // Add language key between baseUrl and /investments for English or Ukrainian
  let investmentsPath = "/investments/";
  if (language === "en") {
    investmentsPath = "/en/investments/";
  } else if (language === "uk") {
    investmentsPath = "/uk/investments/";
  }

  return {
    id: apiProject.id.toString(),
    title: apiProject.h1,
    imageUrl: fullImageUrl,
    date: formatDate(apiProject.published),
    price: extractPriceFromAttr(apiProject.attr),
    starCount: apiProject.rating_2 || 0,
    viewCount: apiProject.views_1 || 0,
    altText: apiProject.short_text,
    href: `${baseUrl}${investmentsPath}${apiProject.subpath}`,
  };
};

// Get the appropriate API endpoint based on language
const getApiEndpoint = (
  language: string,
  baseUrl: string,
  page?: number
): string => {
  const pageParam = page ? `&page=${page}` : "";

  switch (language) {
    case "en":
      return `${baseUrl}/investments?InvestsEnSearch%5Battr58%5D=1${pageParam}`;
    case "uk":
      return `${baseUrl}/investycii?InvestsUkSearch%5Battr58%5D=1${pageParam}`;
    case "ru":
    default:
      return `${baseUrl}/investicii?InvestsRuSearch[attr58]=1${pageParam}`;
  }
};

export const useProjects = (options: UseProjectsOptions = {}) => {
  const { currentLanguage } = useTranslation();

  // Consolidated state to reduce rerenders
  const [state, setState] = useState<ProjectsState>({
    projects: [],
    loading: true,
    loadingMore: false,
    error: null,
    hasMore: true,
    currentPage: 1,
  });

  // Memoize configuration to prevent unnecessary effect triggers
  const config = useMemo(
    () => ({
      baseUrl: options.baseUrl || "https://api.inventure.com.ua",
      enablePagination: options.enablePagination ?? true,
      displayBaseUrl: "https://inventure.com.ua",
    }),
    [options.baseUrl, options.enablePagination]
  );

  // Memoize the fetch function to prevent recreation on every render
  const fetchProjects = useCallback(
    async (page = 1, append = false) => {
      try {
        if (append) {
          setState((prev) => ({ ...prev, loadingMore: true }));
        } else {
          setState((prev) => ({
            ...prev,
            loading: true,
            projects: [],
          }));
        }
        setState((prev) => ({ ...prev, error: null }));

        const endpoint = config.enablePagination
          ? getApiEndpoint(currentLanguage, config.baseUrl, page)
          : getApiEndpoint(currentLanguage, config.baseUrl);

        const response = await fetch(endpoint, {
          headers: {
            Accept: "application/json",
          },
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data: ApiProject[] = await response.json();
        const mappedProjects = data.map((project) =>
          mapApiProjectToProjectItem(
            project,
            config.displayBaseUrl,
            currentLanguage
          )
        );

        setState((prev) => ({
          ...prev,
          projects: append
            ? [...prev.projects, ...mappedProjects]
            : mappedProjects,
          hasMore: config.enablePagination
            ? mappedProjects.length === 20
            : false,
          currentPage: page,
          loading: false,
          loadingMore: false,
        }));
      } catch (err) {
        setState((prev) => ({
          ...prev,
          error:
            err instanceof Error ? err.message : "Failed to fetch projects",
          loading: false,
          loadingMore: false,
        }));
      }
    },
    [config, currentLanguage]
  );

  // Stabilize loadMore callback to prevent unnecessary rerenders
  const loadMore = useCallback(() => {
    if (
      !state.loadingMore &&
      !state.loading &&
      state.hasMore &&
      config.enablePagination
    ) {
      const nextPage = state.currentPage + 1;
      fetchProjects(nextPage, true);
    }
  }, [
    state.loadingMore,
    state.loading,
    state.hasMore,
    state.currentPage,
    config.enablePagination,
    fetchProjects,
  ]);

  // Stabilize refetch callback
  const refetch = useCallback(() => {
    setState((prev) => ({
      ...prev,
      currentPage: 1,
      hasMore: true,
    }));
    fetchProjects(1, false);
  }, [fetchProjects]);

  // Effect to fetch projects when dependencies change
  useEffect(() => {
    fetchProjects(1, false);
  }, [fetchProjects]);

  return {
    projects: state.projects,
    loading: state.loading,
    loadingMore: state.loadingMore,
    error: state.error,
    hasMore: state.hasMore,
    loadMore,
    refetch,
  };
};
