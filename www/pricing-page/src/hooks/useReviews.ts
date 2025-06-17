import { useState, useEffect } from "react";
import { useTranslation } from "./useTranslation";

// API response interfaces
export interface ApiReview {
  id: number;
  image_url: string;
  category: string;
  first_name: string;
  last_name: string;
  company: string;
  job: string;
  rtext: string;
  facebook_url?: string;
  linkedin_url?: string;
  published: string;
  created: string;
  updated: string;
  status: number;
  lang: string;
}

// Transformed review interface for the UI
export interface ReviewItem {
  id: string;
  name: string;
  title: string;
  subtitle: string;
  review: string;
  profileImage: string;
  linkedinUrl?: string;
  facebookUrl?: string;
}

interface UseReviewsOptions {
  baseUrl?: string;
}

// Map API review to ReviewItem format
export const mapApiReviewToReviewItem = (review: ApiReview): ReviewItem => {
  return {
    id: String(review.id),
    name: `${review.first_name} ${review.last_name}`,
    title: review.job,
    subtitle: review.company,
    review: review.rtext,
    profileImage: review.image_url,
    linkedinUrl: review.linkedin_url || "",
    facebookUrl: review.facebook_url || "",
  };
};

// Get API endpoint based on language
const getApiEndpoint = (language: string, baseUrl: string): string => {
  switch (language) {
    case "uk":
      return `${baseUrl}/vidhuky`;
    case "en":
      return `${baseUrl}/reviews`;
    case "ru":
    default:
      return `${baseUrl}/otzyvy`;
  }
};

export const useReviews = (options: UseReviewsOptions = {}) => {
  const [reviews, setReviews] = useState<ReviewItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { currentLanguage } = useTranslation();

  const baseUrl = options.baseUrl || "https://api.inventure.com.ua";

  const fetchReviews = async () => {
    try {
      setLoading(true);
      setError(null);

      const endpoint = getApiEndpoint(currentLanguage, baseUrl);
      const response = await fetch(endpoint, {
        headers: {
          "Content-Type": "application/json",
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const data: ApiReview[] = await response.json();
      const mappedReviews = data.map((review) =>
        mapApiReviewToReviewItem(review)
      );

      setReviews(mappedReviews);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to fetch reviews");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchReviews();
  }, [baseUrl, currentLanguage]);

  return {
    reviews,
    loading,
    error,
    refetch: fetchReviews,
  };
};
