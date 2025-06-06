import * as React from "react";

export const ProjectCardSkeleton: React.FC = () => {
  return (
    <article className="flex overflow-hidden flex-col h-full rounded-lg border border-gray-100 border-solid w-full max-md:mx-auto max-md:my-0 max-md:w-full animate-pulse">
      {/* Image skeleton */}
      <div className="w-full h-[250px] bg-gray-200"></div>

      <div className="flex flex-col px-4 py-4 max-sm:p-4 flex-1">
        {/* Date skeleton */}
        <div className="h-5 bg-gray-200 rounded w-20 mb-1"></div>

        {/* Title skeleton */}
        <div className="space-y-2 mb-4">
          <div className="h-5 bg-gray-200 rounded w-full"></div>
          <div className="h-5 bg-gray-200 rounded w-3/4"></div>
        </div>

        <div className="flex justify-between items-center mt-auto pt-2">
          {/* Price skeleton */}
          <div className="h-6 bg-gray-200 rounded-full w-20"></div>

          <div className="flex gap-2 items-center max-sm:gap-2">
            {/* Star rating skeleton */}
            <div className="flex gap-1 items-center">
              <div className="h-4 w-4 bg-gray-200 rounded"></div>
              <div className="h-4 bg-gray-200 rounded w-4"></div>
            </div>

            {/* View count skeleton */}
            <div className="flex gap-1 items-center">
              <div className="h-4 w-4 bg-gray-200 rounded"></div>
              <div className="h-4 bg-gray-200 rounded w-6"></div>
            </div>
          </div>
        </div>
      </div>
    </article>
  );
};
