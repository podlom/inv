import { useState, useEffect } from "react";
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
  baseUrl = "https://inventure.com.ua"
): ProjectItem => {
  const fullImageUrl = apiProject.image_url.startsWith("http")
    ? apiProject.image_url
    : `${baseUrl}${apiProject.image_url}`;

  return {
    id: apiProject.id.toString(),
    title: apiProject.h1,
    imageUrl: fullImageUrl,
    date: formatDate(apiProject.published),
    price: extractPriceFromAttr(apiProject.attr),
    starCount: apiProject.rating_2 || 0,
    viewCount: apiProject.views_1 || 0,
    altText: apiProject.short_text,
    href: `${baseUrl}/investments/${apiProject.subpath}`,
  };
};

// Get the appropriate API endpoint based on language
const getApiEndpoint = (language: string, baseUrl: string): string => {
  switch (language) {
    case "en":
      return `${baseUrl}/investments?InvestsEnSearch%5Battr58%5D=1`;
    case "uk":
      return `${baseUrl}/investycii?InvestsUkSearch%5Battr58%5D=1`;
    case "ru":
    default:
      return `${baseUrl}/investicii?InvestsRuSearch[attr58]=1`;
  }
};

export const useProjects = (options: UseProjectsOptions = {}) => {
  const [projects, setProjects] = useState<ProjectItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { currentLanguage } = useTranslation();

  const baseUrl = options.baseUrl || "https://api.inventure.com.ua";

  const fetchProjects = async () => {
    try {
      setLoading(true);
      setError(null);

      const endpoint = getApiEndpoint(currentLanguage, baseUrl);
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
        mapApiProjectToProjectItem(project, "https://inventure.com.ua")
      );

      setProjects(mappedProjects);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to fetch projects");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProjects();
  }, [baseUrl, currentLanguage]);

  return {
    projects,
    loading,
    error,
    refetch: fetchProjects,
  };
};
