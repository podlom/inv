"use client";

import { ArrowLeft, ArrowRight } from "lucide-react";
import { useEffect, useState } from "react";

import { Button } from "@/components/ui/button";
import {
  Carousel,
  type CarouselApi,
  CarouselContent,
  CarouselItem,
} from "@/components/ui/carousel";
import { ProjectCard } from "../ProjectCard";
import { ProjectCardSkeleton } from "../ProjectCardSkeleton";
import { ReviewCard } from "../ReviewCard";
import { ReviewModal } from "../ReviewModal";
import { cn } from "@/lib/utils";
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
}

// Helper function to check if item is a project
const isProjectItem = (item: GalleryItem): item is ProjectItem => {
  return "price" in item || "starCount" in item || "viewCount" in item;
};

// Helper function to check if item is a review
const isReviewItem = (item: GalleryItem): item is ReviewItem => {
  return "name" in item && "review" in item && "profileImage" in item;
};

export const Gallery = ({
  title = "",
  description = "",
  data,
  type = "projects",
  showAllLink,
  loading = false,
}: GalleryProps) => {
  const { t } = useTranslation();
  const [carouselApi, setCarouselApi] = useState<CarouselApi>();
  const [canScrollPrev, setCanScrollPrev] = useState(false);
  const [canScrollNext, setCanScrollNext] = useState(false);
  const [currentSlide, setCurrentSlide] = useState(0);
  const [selectedReview, setSelectedReview] = useState<ReviewItem | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  // Use data prop, then items prop, then default data based on type
  const galleryItems = data || [];

  // Create skeleton items when loading
  const skeletonItems = Array.from({ length: 6 }, (_, index) => ({
    id: `skeleton-${index}`,
    title: "",
    imageUrl: "",
    date: "",
    price: "",
    starCount: 0,
    viewCount: 0,
    altText: "",
    href: "",
  }));

  // Use skeleton items when loading, otherwise use actual data
  const displayItems = loading ? skeletonItems : galleryItems;

  const handleReadMore = (review: ReviewItem) => {
    setSelectedReview(review);
    setIsModalOpen(true);
  };

  useEffect(() => {
    if (!carouselApi) {
      return;
    }
    const updateSelection = () => {
      setCanScrollPrev(carouselApi.canScrollPrev());
      setCanScrollNext(carouselApi.canScrollNext());
      setCurrentSlide(carouselApi.selectedScrollSnap());
    };
    updateSelection();
    carouselApi.on("select", updateSelection);
    return () => {
      carouselApi.off("select", updateSelection);
    };
  }, [carouselApi]);

  // Get localized title and description based on type
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

  const localizedTitle = getLocalizedTitle();
  const localizedDescription = getLocalizedDescription();

  return (
    <section>
      <div className="mx-auto mb-6 md:mb-8">
        <div className="container mx-auto flex items-end justify-between">
          <div className="flex flex-col">
            <h2
              className={cn(
                "text-3xl md:text-4xl leading-none font-bold",
                localizedDescription ? "max-w-xs" : ""
              )}
            >
              {localizedTitle.split("\n").map((line, index) => (
                <span key={index}>
                  {line}
                  {index < localizedTitle.split("\n").length - 1 && <br />}
                </span>
              ))}
            </h2>
            {localizedDescription && (
              <p className="max-w-lg mt-6 text-muted-foreground">
                {localizedDescription}
              </p>
            )}
          </div>
          {showAllLink && (
            <div className="hidden lg:flex flex-col items-end">
              <a
                href={showAllLink}
                target="_blank"
                className="flex items-center gap-2 text-sm font-medium text-[#286080] hover:text-[#286080]/80 transition-colors"
              >
                {t("gallery.projects.viewAll")}
                <ArrowRight className="size-4" />
              </a>
            </div>
          )}
        </div>
      </div>
      <div className="relative ">
        <Carousel
          setApi={setCarouselApi}
          className="mb-4 md:mb-8"
          opts={{
            breakpoints: {
              "(max-width: 768px)": {
                dragFree: true,
              },
            },
            align: "start",
          }}
        >
          {/* sm:mx-[calc((100vw-640px)/2+24px)] md:mx-[calc((100vw-768px)/2+24px)] lg:mx-[calc((100vw-1024px)/2+32px)] xl:mx-[calc((100vw-1280px)/2+32px)] 2xl:mx-[calc((100vw-80rem)/2+32px)] */}
          <CarouselContent className="mx-5 sm:mx-[calc((100vw-640px)/2+24px)] md:mx-[calc((100vw-768px)/2+24px)] lg:mx-[calc((100vw-1024px)/2+28px)] xl:mx-[calc((100vw-1280px)/2+28px)] 2xl:mx-[calc((100vw-96rem)/2+24px)]">
            {displayItems.map((item, index) => (
              <CarouselItem
                key={item.id}
                className={cn(
                  "max-w-[320px] pl-0 pr-[20px] lg:max-w-[360px]",
                  index === 0 && "pl-0",
                  index === displayItems.length - 1 && "pr-0"
                )}
              >
                {loading && type === "projects" ? (
                  <div className="group relative h-full max-w-full overflow-hidden">
                    <ProjectCardSkeleton />
                  </div>
                ) : type === "projects" && isProjectItem(item) ? (
                  <a href={item.href} target="_blank" className="group h-full">
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
            ))}
          </CarouselContent>
        </Carousel>
        <div className=" flex justify-between items-center container mx-auto">
          <div
            className={cn(
              "w-[88px] overflow-hidden rounded-full p-2",
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
                  (currentSlide - 2) * 16
                )}px)`,
                width: `${displayItems.length * 16}px`,
              }}
            >
              {displayItems.map((_, index) => (
                <button
                  key={index}
                  className={`h-2 w-2 rounded-full transition-colors flex-shrink-0 ${
                    currentSlide === index ? "bg-[#286080]" : "bg-[#286080]/20"
                  }`}
                  onClick={() => carouselApi?.scrollTo(index)}
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
              onClick={() => {
                carouselApi?.scrollPrev();
              }}
              disabled={!canScrollPrev}
              className={cn(
                "disabled:pointer-events-auto h-8 w-8 rounded-full disabled:opacity-50",
                type === "reviews"
                  ? "bg-white hover:bg-gray-50 disabled:text-[#286080]/50"
                  : "bg-[#286080]/10 hover:bg-[#286080]/20 disabled:bg-[#286080]/5"
              )}
            >
              <ArrowLeft className="size-4 text-[#286080]" />
            </Button>
            <Button
              size="icon"
              variant="ghost"
              onClick={() => {
                carouselApi?.scrollNext();
              }}
              disabled={!canScrollNext}
              className={cn(
                "disabled:pointer-events-auto h-8 w-8 rounded-full disabled:opacity-50",
                type === "reviews"
                  ? "bg-white hover:bg-gray-50 disabled:bg-gray-50"
                  : "bg-[#286080]/10 hover:bg-[#286080]/20 disabled:bg-[#286080]/5"
              )}
            >
              <ArrowRight className="size-4 text-[#286080]" />
            </Button>
          </div>
          {showAllLink && (
            <a
              href={showAllLink}
              className="flex lg:hidden justify-center items-center gap-2 text-sm font-medium  text-[#286080] hover:text-[#286080]/80 transition-colors"
            >
              {t("gallery.projects.viewAll")}
              <ArrowRight className="size-4" />
            </a>
          )}
        </div>
      </div>
      {selectedReview && (
        <ReviewModal
          isOpen={isModalOpen}
          onOpenChange={setIsModalOpen}
          name={selectedReview.name}
          title={selectedReview.title}
          subtitle={selectedReview.subtitle || ""}
          review={selectedReview.review}
          profileImage={selectedReview.profileImage}
          linkedinUrl={selectedReview.linkedinUrl}
          facebookUrl={selectedReview.facebookUrl}
        />
      )}
    </section>
  );
};
