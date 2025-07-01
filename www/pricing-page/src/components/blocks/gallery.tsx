"use client";

import { ArrowLeft, ArrowRight } from "lucide-react";
import { useEffect, useState, useMemo, useCallback, memo } from "react";

import { Button } from "../ui/button";
import {
  Carousel,
  type CarouselApi,
  CarouselContent,
  CarouselItem,
} from "../ui/carousel";
import { ProjectCard } from "../ProjectCard";
import { ProjectCardSkeleton } from "../ProjectCardSkeleton";
import { ReviewCard } from "../ReviewCard";
import { ReviewCardSkeleton } from "../ReviewCardSkeleton";
import { ReviewModal } from "../ReviewModal";
import { cn } from "../../lib/utils";
import { useTranslation } from "../../hooks/useTranslation";

// Project item interface
export interface ProjectItem {
  id: string;
  imageUrl?: string;
  date?: string;
  title?: string;
  price?: string;
  starCount?: number;
  viewCount?: number;
  altText?: string;
  href?: string;
}

// Review item interface
export interface ReviewItem {
  id: string;
  name: string;
  title: string;
  subtitle?: string;
  review: string;
  profileImage: string;
  linkedinUrl?: string;
  facebookUrl?: string;
}

// Union type for gallery items
export type GalleryItem = ProjectItem | ReviewItem;

export interface GalleryProps {
  title?: string;
  description?: string;
  data?: GalleryItem[];
  type: "projects" | "reviews";
  showAllLink?: string;
  loading?: boolean;
  loadingMore?: boolean;
  hasMore?: boolean;
  onLoadMore?: () => void;
}

// Consolidated state interface
interface GalleryState {
  carouselApi: CarouselApi | null;
  canScrollPrev: boolean;
  canScrollNext: boolean;
  currentSlide: number;
  selectedReview: ReviewItem | null;
  isModalOpen: boolean;
}

// Helper function to check if item is a project
const isProjectItem = (item: GalleryItem): item is ProjectItem => {
  return "price" in item || "starCount" in item || "viewCount" in item;
};

// Helper function to check if item is a review
const isReviewItem = (item: GalleryItem): item is ReviewItem => {
  return "name" in item && "review" in item && "profileImage" in item;
};

export const Gallery = memo(
  ({
    title = "",
    description = "",
    data,
    type = "projects",
    showAllLink,
    loading = false,
    loadingMore = false,
    hasMore = false,
    onLoadMore,
  }: GalleryProps) => {
    const { t } = useTranslation();

    // Consolidated state to reduce rerenders
    const [state, setState] = useState<GalleryState>({
      carouselApi: null,
      canScrollPrev: false,
      canScrollNext: false,
      currentSlide: 0,
      selectedReview: null,
      isModalOpen: false,
    });

    // Use data prop, then items prop, then default data based on type
    const galleryItems = data || [];

    // Memoize skeleton items to prevent recreation on every render
    const skeletonItems = useMemo(() => {
      return Array.from({ length: 6 }, (_, index) => {
        if (type === "reviews") {
          return {
            id: `skeleton-${index}`,
            name: "",
            title: "",
            subtitle: "",
            review: "",
            profileImage: "",
            linkedinUrl: "",
            facebookUrl: "",
          };
        }
        return {
          id: `skeleton-${index}`,
          title: "",
          imageUrl: "",
          date: "",
          price: "",
          starCount: 0,
          viewCount: 0,
          altText: "",
          href: "",
        };
      });
    }, [type]);

    // Memoize loading more skeleton items
    const loadingMoreSkeletons = useMemo(() => {
      return Array.from({ length: 3 }, (_, index) => {
        if (type === "reviews") {
          return {
            id: `loading-more-skeleton-${index}`,
            name: "",
            title: "",
            subtitle: "",
            review: "",
            profileImage: "",
            linkedinUrl: "",
            facebookUrl: "",
          };
        }
        return {
          id: `loading-more-skeleton-${index}`,
          title: "",
          imageUrl: "",
          date: "",
          price: "",
          starCount: 0,
          viewCount: 0,
          altText: "",
          href: "",
        };
      });
    }, [type]);

    // Memoize display items to prevent unnecessary array operations
    const displayItems = useMemo(() => {
      if (loading) {
        return skeletonItems;
      }
      if (hasMore) {
        return [...galleryItems, ...loadingMoreSkeletons];
      }
      return galleryItems;
    }, [loading, hasMore, galleryItems, skeletonItems, loadingMoreSkeletons]);

    // Memoize localized content to prevent translation recalculation
    const localizedContent = useMemo(() => {
      const getLocalizedTitle = () => {
        if (title) return title;
        return type === "projects"
          ? t("gallery.projects.title")
          : t("gallery.reviews.title");
      };

      const getLocalizedDescription = () => {
        if (description) return description;
        return type === "reviews" ? t("gallery.reviews.description") : "";
      };

      return {
        title: getLocalizedTitle(),
        description: getLocalizedDescription(),
      };
    }, [title, description, type, t]);

    // Memoize carousel options to prevent recreation
    const carouselOpts = useMemo(
      () => ({
        dragFree: true,
        align: "start" as const,
      }),
      []
    );

    const handleReadMore = useCallback((review: ReviewItem) => {
      setState((prev) => ({
        ...prev,
        selectedReview: review,
        isModalOpen: true,
      }));
    }, []);

    const updateNavigationState = useCallback((api: CarouselApi) => {
      if (!api) return;
      setState((prev) => ({
        ...prev,
        canScrollPrev: api.canScrollPrev(),
        canScrollNext: api.canScrollNext(),
        currentSlide: api.selectedScrollSnap(),
      }));
    }, []);

    // Memoize slide change handler to prevent recreation
    const handleSlideChange = useCallback(
      (api: CarouselApi) => {
        if (!api) return;

        updateNavigationState(api);

        // Trigger load more when user is close to the end (3 slides before the end)
        if (
          onLoadMore &&
          hasMore &&
          !loadingMore &&
          !loading &&
          type === "projects"
        ) {
          const totalSlides = galleryItems.length;
          const currentIndex = api.selectedScrollSnap();
          const slidesPerView = 3; // Estimate based on responsive design
          const threshold = 3; // Load more when 3 slides from the end

          if (currentIndex + slidesPerView >= totalSlides - threshold) {
            onLoadMore();
          }
        }
      },
      [
        updateNavigationState,
        onLoadMore,
        hasMore,
        loadingMore,
        loading,
        type,
        galleryItems.length,
      ]
    );

    // Memoize carousel navigation handlers
    const handleScrollPrev = useCallback(() => {
      state.carouselApi?.scrollPrev();
    }, [state.carouselApi]);

    const handleScrollNext = useCallback(() => {
      state.carouselApi?.scrollNext();
    }, [state.carouselApi]);

    const handleSlideClick = useCallback(
      (index: number) => {
        state.carouselApi?.scrollTo(index);
      },
      [state.carouselApi]
    );

    const handleModalOpenChange = useCallback((open: boolean) => {
      setState((prev) => ({
        ...prev,
        isModalOpen: open,
      }));
    }, []);

    const setCarouselApi = useCallback((api: CarouselApi) => {
      setState((prev) => ({
        ...prev,
        carouselApi: api,
      }));
    }, []);

    useEffect(() => {
      if (!state.carouselApi) {
        return;
      }

      const updateSelection = () => {
        handleSlideChange(state.carouselApi!);
      };

      updateSelection();
      state.carouselApi.on("select", updateSelection);

      return () => {
        state.carouselApi?.off("select", updateSelection);
      };
    }, [state.carouselApi, handleSlideChange]);

    return (
      <div>
        <div className="mx-auto mb-6 md:mb-8">
          <div className="container mx-auto flex items-end justify-between">
            <div className="flex flex-col">
              <h2
                className={cn(
                  "text-3xl md:text-4xl leading-none font-bold",
                  localizedContent.description ? "max-w-xs" : ""
                )}
              >
                {localizedContent.title.split("\n").map((line, index) => (
                  <span key={index}>
                    {line}
                    {index < localizedContent.title.split("\n").length - 1 && (
                      <br />
                    )}
                  </span>
                ))}
              </h2>
              {localizedContent.description && (
                <p className="max-w-lg lg:text-lg mt-6 text-muted-foreground">
                  {localizedContent.description}
                </p>
              )}
            </div>
            {showAllLink && (
              <div className="hidden lg:flex flex-col items-end">
                <a
                  href={showAllLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex  items-center gap-2 font-medium text-[#286080] hover:text-[#286080]/80 transition-colors"
                >
                  {t("gallery.projects.viewAll")}
                  <ArrowRight className="size-4" />
                </a>
              </div>
            )}
          </div>
        </div>
        <div className="relative">
          <Carousel
            setApi={setCarouselApi}
            className="mb-4 md:mb-8"
            opts={carouselOpts}
          >
            <CarouselContent className="mx-5 sm:mx-[calc((100vw-640px)/2+24px)] md:mx-[calc((100vw-768px)/2+24px)] lg:mx-[calc((100vw-1024px)/2+28px)] xl:mx-[calc((100vw-1280px)/2+28px)] 2xl:mx-[calc((100vw-96rem)/2+24px)]">
              {displayItems.map((item, index) => {
                const isLoadingMoreSkeleton =
                  hasMore && index >= galleryItems.length;

                return (
                  <CarouselItem
                    key={item.id}
                    className={cn(
                      "max-w-[320px] pl-0 pr-[20px] lg:max-w-[360px]",
                      index === 0 && "pl-0",
                      index === displayItems.length - 1 && "pr-0"
                    )}
                  >
                    {(loading && type === "projects") ||
                    (isLoadingMoreSkeleton && type === "projects") ? (
                      <div className="group relative h-full max-w-full overflow-hidden">
                        <ProjectCardSkeleton />
                      </div>
                    ) : (loading && type === "reviews") ||
                      (isLoadingMoreSkeleton && type === "reviews") ? (
                      <div className="group relative h-full max-w-full overflow-hidden">
                        <ReviewCardSkeleton />
                      </div>
                    ) : type === "projects" && isProjectItem(item) ? (
                      <a
                        href={item.href}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="group h-full"
                      >
                        <div className="group relative h-full max-w-full overflow-hidden ">
                          <ProjectCard
                            imageUrl={item.imageUrl}
                            date={item.date}
                            title={item.title}
                            price={item.price}
                            starCount={item.starCount}
                            viewCount={item.viewCount}
                            altText={item.altText}
                          />
                        </div>
                      </a>
                    ) : type === "reviews" && isReviewItem(item) ? (
                      <div className="group relative h-full max-w-full overflow-hidden ">
                        <ReviewCard
                          name={item.name}
                          title={item.title}
                          subtitle={item.subtitle}
                          review={item.review}
                          profileImage={item.profileImage}
                          linkedinUrl={item.linkedinUrl}
                          facebookUrl={item.facebookUrl}
                          onReadMore={() => handleReadMore(item)}
                        />
                      </div>
                    ) : null}
                  </CarouselItem>
                );
              })}
            </CarouselContent>
          </Carousel>
          <div className="flex justify-between items-center container mx-auto">
            <div
              className={cn(
                "w-[88px] h-[40px] flex items-center overflow-hidden rounded-full p-2",
                type === "reviews"
                  ? "bg-white border border-[#ECEEF0]"
                  : "bg-[#286080]/10"
              )}
            >
              <div
                className="flex gap-2 transition-transform duration-300 ease-out"
                style={{
                  transform: `translateX(-${Math.max(
                    0,
                    (state.currentSlide - 2) * 16
                  )}px)`,
                  width: `${displayItems.length * 16}px`,
                }}
              >
                {displayItems.map((_, index) => (
                  <button
                    key={index}
                    className={`h-2 w-2 rounded-full transition-colors flex-shrink-0 ${
                      state.currentSlide === index
                        ? "bg-[#286080]"
                        : "bg-[#286080]/20"
                    }`}
                    onClick={() => handleSlideClick(index)}
                    aria-label={`Go to slide ${index + 1}`}
                  />
                ))}
              </div>
            </div>
            <div
              className={cn(
                "lg:flex shrink-0 gap-2",
                showAllLink ? "hidden" : "flex"
              )}
            >
              <Button
                size="icon"
                variant="ghost"
                onClick={handleScrollPrev}
                disabled={!state.canScrollPrev}
                className={cn(
                  "disabled:pointer-events-auto h-10 w-10 rounded-full disabled:opacity-50",
                  type === "reviews"
                    ? "bg-white hover:bg-gray-50 disabled:text-[#286080]/50"
                    : "bg-[#286080]/10 hover:bg-[#286080]/20 disabled:bg-[#286080]/5"
                )}
              >
                <ArrowLeft className="size-5 text-[#286080]" />
              </Button>
              <Button
                size="icon"
                variant="ghost"
                onClick={handleScrollNext}
                disabled={!state.canScrollNext}
                className={cn(
                  "disabled:pointer-events-auto h-10 w-10 rounded-full disabled:opacity-50",
                  type === "reviews"
                    ? "bg-white hover:bg-gray-50 disabled:bg-gray-50"
                    : "bg-[#286080]/10 hover:bg-[#286080]/20 disabled:bg-[#286080]/5"
                )}
              >
                <ArrowRight className="size-5 text-[#286080]" />
              </Button>
            </div>
            {showAllLink && (
              <a
                href={showAllLink}
                target="_blank"
                rel="noopener noreferrer"
                className="flex lg:hidden justify-center items-center gap-2 text-sm font-medium  text-[#286080] hover:text-[#286080]/80 transition-colors"
              >
                {t("gallery.projects.viewAll")}
                <ArrowRight className="size-4" />
              </a>
            )}
          </div>
        </div>
        {state.selectedReview && (
          <ReviewModal
            isOpen={state.isModalOpen}
            onOpenChange={handleModalOpenChange}
            name={state.selectedReview.name}
            title={state.selectedReview.title}
            subtitle={state.selectedReview.subtitle || ""}
            review={state.selectedReview.review}
            profileImage={state.selectedReview.profileImage}
            linkedinUrl={state.selectedReview.linkedinUrl}
            facebookUrl={state.selectedReview.facebookUrl}
          />
        )}
      </div>
    );
  }
);

Gallery.displayName = "Gallery";
