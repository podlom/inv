import * as React from "react";
import { Card, CardContent } from "./ui/card";

export const ReviewCardSkeleton: React.FC = () => {
  return (
    <Card className="max-w-md mx-auto h-full bg-white/50 backdrop-blur-xl border-[#ECEEF0] animate-pulse">
      <CardContent className="p-4 lg:p-6 h-full flex flex-col">
        {/* Review Text Skeleton */}
        <div className="mb-4 space-y-2">
          <div className="h-5 bg-gray-200 rounded w-full"></div>
          <div className="h-5 bg-gray-200 rounded w-full"></div>
          <div className="h-5 bg-gray-200 rounded w-3/4"></div>
          <div className="h-5 bg-gray-200 rounded w-full"></div>
          <div className="h-5 bg-gray-200 rounded w-2/3"></div>
        </div>

        {/* Read More Button Skeleton */}
        <div className="h-5 bg-gray-200 rounded w-24 mb-4"></div>

        {/* Separator */}
        <div className="w-full h-px bg-gray-200 mb-4"></div>

        {/* Profile Section Skeleton */}
        <div className="flex items-center gap-3 mt-auto">
          {/* Profile Image Skeleton */}
          <div className="w-12 h-12 bg-gray-200 rounded-full flex-shrink-0"></div>

          {/* Profile Info Skeleton */}
          <div className="flex-1 min-w-0 space-y-1">
            <div className="h-4 bg-gray-200 rounded w-3/4"></div>
            <div className="h-3 bg-gray-200 rounded w-1/2"></div>
            {/* Social Links Skeleton */}
            <div className="flex gap-2 flex-shrink-0">
              <div className="w-6 h-6 bg-gray-200 rounded"></div>
              <div className="w-6 h-6 bg-gray-200 rounded"></div>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};
