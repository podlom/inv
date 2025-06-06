import React from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "./ui/dialog";
import { Drawer, DrawerContent, DrawerHeader, DrawerTitle } from "./ui/drawer";
import { useMediaQuery } from "../hooks/useMediaQuery";
import { useTranslation } from "../hooks/useTranslation";
import linkedin from "../assets/linkedin.svg";
import facebook from "../assets/facebook.svg";

interface ReviewModalProps {
  isOpen: boolean;
  onOpenChange: (open: boolean) => void;
  name: string;
  title: string;
  subtitle: string;
  review: string;
  profileImage: string;
  linkedinUrl?: string;
  facebookUrl?: string;
}

export const ReviewModal: React.FC<ReviewModalProps> = ({
  isOpen,
  onOpenChange,
  name,
  title,
  subtitle,
  review,
  profileImage,
  linkedinUrl,
  facebookUrl,
}) => {
  const { t } = useTranslation();
  const isDesktop = useMediaQuery("(min-width: 768px)");

  const ClientInfo = () => (
    <div className="border-t border-gray-200 p-6 bg-gray-50">
      <div className="flex items-center space-x-4">
        {/* Profile Image */}
        <div className="flex-shrink-0">
          <img
            src={profileImage}
            alt={`${name} profile`}
            className="w-16 h-16 rounded-full object-cover border-2 border-gray-200"
          />
        </div>

        {/* Client Info */}
        <div className="flex-grow">
          <h3 className="text-lg font-semibold text-gray-900 leading-none">
            {name}
          </h3>
          <p className="text-sm text-gray-600 mb-1">
            {title}
            {subtitle ? `, ${subtitle}` : ""}
          </p>

          {/* Social Media Icons */}
          <div className="flex space-x-3">
            {linkedinUrl && (
              <a
                href={linkedinUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center justify-center size-5 hover:opacity-80 transition-opacity"
              >
                <img src={linkedin} alt="Linkedin" className="" />
              </a>
            )}
            {facebookUrl && (
              <a
                href={facebookUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center justify-center size-5 hover:opacity-80 transition-opacity"
              >
                <img src={facebook} alt="Facebook" className="" />
              </a>
            )}
          </div>
        </div>
      </div>
    </div>
  );

  return (
    <>
      {isDesktop ? (
        <Dialog open={isOpen} onOpenChange={onOpenChange}>
          <DialogContent className="max-w-2xl bg-white max-h-[90dvh] overflow-hidden p-0">
            <DialogHeader className="p-4 border-b border-gray-200">
              <DialogTitle className="text-xl font-semibold text-gray-900">
                {t("gallery.reviews.reviewTitle")}
              </DialogTitle>
            </DialogHeader>

            {/* Review Content */}
            <div className="p-6 overflow-y-auto max-h-[calc(90vh-200px)]">
              <p className="text-gray-700 text-base leading-relaxed mb-6">
                {review}
              </p>
            </div>

            {/* Client Information Footer */}
            <ClientInfo />
          </DialogContent>
        </Dialog>
      ) : (
        <Drawer open={isOpen} onOpenChange={onOpenChange}>
          <DrawerContent className="max-h-[90dvh] bg-white">
            <DrawerHeader className="border-b border-gray-200">
              <DrawerTitle className="text-xl font-semibold text-gray-900">
                {t("gallery.reviews.reviewTitle")}
              </DrawerTitle>
            </DrawerHeader>

            {/* Review Content */}
            <div className="p-4 overflow-y-auto flex-1">
              <p className="text-gray-700 text-base leading-relaxed mb-6">
                {review}
              </p>
            </div>

            {/* Client Information Footer */}
            <ClientInfo />
          </DrawerContent>
        </Drawer>
      )}
    </>
  );
};
