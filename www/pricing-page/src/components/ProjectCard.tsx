"use client";
import * as React from "react";
import { StarIcon, EyeIcon } from "lucide-react";
import { useTranslation } from "../hooks/useTranslation";

interface ProjectCardProps {
  imageUrl?: string;
  date?: string;
  title?: string;
  price?: string;
  starCount?: number;
  viewCount?: number;
  altText?: string;
}

// Utility function to format date based on locale
const formatDateForLocale = (dateString: string, locale: string): string => {
  try {
    // Handle ISO format (YYYY-MM-DD HH:MM:SS) from projects.json
    if (dateString.includes("-") && dateString.length >= 10) {
      const date = new Date(dateString);

      // Check if date is valid
      if (!isNaN(date.getTime())) {
        return new Intl.DateTimeFormat(locale, {
          day: "2-digit",
          month: "2-digit",
          year: "numeric",
        }).format(date);
      }
    }

    // Fallback: Handle DD.MM.YY format
    const parts = dateString.split(".");
    if (parts.length === 3) {
      const day = parseInt(parts[0], 10);
      const month = parseInt(parts[1], 10) - 1; // Month is 0-indexed
      const year = parseInt(parts[2], 10);

      // Handle 2-digit year (assuming 20xx)
      const fullYear = year < 50 ? 2000 + year : 1900 + year;

      const date = new Date(fullYear, month, day);

      // Format according to locale
      return new Intl.DateTimeFormat(locale, {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
      }).format(date);
    }
  } catch (error) {
    console.warn("Error formatting date:", error);
  }

  // Return original string if parsing fails
  return dateString;
};

export const ProjectCard: React.FC<ProjectCardProps> = ({
  imageUrl = "https://cdn.builder.io/api/v1/image/assets/TEMP/46e966511a926f7184cff3a2a79539bb23ca418d",
  date = "21.03.25",
  title,
  price = "$2 700 000",
  starCount = 9,
  viewCount = 235,
  altText = "Metal fabrication machinery in action",
}) => {
  const { t, currentLanguage } = useTranslation();
  const displayTitle = title || t("projectCard.defaultTitle");

  // Format date according to current locale
  const formattedDate = formatDateForLocale(date, currentLanguage);

  // Handle price display - show "Договорная" if price is "0" or "$0"
  const displayPrice =
    price === "0" || price === "$0" || price === "$ 0" ? "Договорная" : price;

  return (
    <article className="flex overflow-hidden flex-col h-full rounded-lg border border-gray-100 border-solid w-full max-md:mx-auto max-md:my-0 max-md:w-full">
      <img
        src={imageUrl}
        className="object-cover w-full h-[240px]"
        alt={altText}
      />
      <div className="flex flex-col px-4 py-4 max-sm:p-4 flex-1">
        <time className="text-sm font-semibold leading-5 text-zinc-500">
          {formattedDate}
        </time>
        <h2 className="mt-1 text-base font-semibold leading-5 text-black">
          {displayTitle}
        </h2>
        <div className="flex justify-between items-center mt-auto pt-2">
          <span className="px-2 py-0 flex items-center text-xs font-semibold leading-6 text-white bg-slate-500 h-[24px] rounded-[50px]">
            {displayPrice}
          </span>
          <div className="flex gap-2 items-center max-sm:gap-2">
            <div className="flex gap-1 items-center text-sm font-semibold ">
              <StarIcon size={16} />
              <span className="leading-none">{starCount}</span>
            </div>
            <div className="flex gap-1 items-center text-sm font-semibold ">
              <EyeIcon size={16} />
              <span className="leading-none">{viewCount}</span>
            </div>
          </div>
        </div>
      </div>
    </article>
  );
};
