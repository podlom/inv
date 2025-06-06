import { ArrowRight } from "lucide-react";
import React from "react";
import facebook from "../assets/facebook.svg";
import linkedin from "../assets/linkedin.svg";
import { Card, CardContent } from "./ui/card";
import { useTranslation } from "../hooks/useTranslation";

interface ReviewCardProps {
  name: string;
  title: string;
  subtitle?: string;
  review: string;
  profileImage: string;
  linkedinUrl?: string;
  facebookUrl?: string;
  onReadMore?: () => void;
}

export const ReviewCard: React.FC<ReviewCardProps> = ({
  name,
  title,
  subtitle,
  review,
  profileImage,
  linkedinUrl,
  facebookUrl,
  onReadMore,
}) => {
  const { t } = useTranslation();

  return (
    <Card className="max-w-md mx-auto h-full bg-white/50 backdrop-blur-xl border-[#ECEEF0] transition-shadow duration-300">
      <CardContent className="p-4 lg:p-6 h-full flex flex-col">
        {/* Review Text */}
        <div className="mb-4">
          <p className="text-gray-700 text-base leading-relaxed line-clamp-5">
            {review}
          </p>
          {onReadMore && (
            <button
              onClick={onReadMore}
              className="text-[#286080] flex items-center gap-2 hover:text-[#286080]/80 text-sm font-medium mt-2 transition-colors focus:outline-none focus:ring-2 focus:ring-[#286080]/20 rounded"
            >
              {t("gallery.reviews.readMore")}
              <ArrowRight className="size-4" />
            </button>
          )}
        </div>

        {/* Separator */}
        <div className="w-full h-px bg-gray-200 mb-4"></div>

        {/* Profile Section */}
        <div className="mt-auto flex items-center space-x-4">
          {/* Profile Image */}
          <div className="flex-shrink-0">
            <img
              src={profileImage}
              alt={`${name} profile`}
              className="w-16 h-16 rounded-full object-cover border-2 border-gray-200"
            />
          </div>

          {/* Name, Title and Social Icons */}
          <div className="grid">
            <h3 className="text-lg font-semibold text-gray-900 leading-none truncate ">
              {name}
            </h3>
            <p className="text-sm text-gray-600 truncate ">
              {title}
              {subtitle ? `, ${subtitle}` : ""}
            </p>

            {/* Social Media Icons */}
            {(linkedinUrl || facebookUrl) && (
              <div className="flex space-x-2 mt-1.5">
                {linkedinUrl && (
                  <a
                    href={linkedinUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center justify-center size-5 hover:opacity-80 transition-opacity"
                  >
                    <img src={linkedin} alt="Linkedin" />
                  </a>
                )}
                {facebookUrl && (
                  <a
                    href={facebookUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center justify-center size-5 hover:opacity-80 transition-opacity"
                  >
                    <img src={facebook} alt="Facebook" />
                  </a>
                )}
              </div>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
};
