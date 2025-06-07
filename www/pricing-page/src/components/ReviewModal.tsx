import * as Dialog from "@radix-ui/react-dialog";
import React from "react";
import { animated, config, useTransition } from "react-spring";
import facebook from "../assets/facebook.svg";
import linkedin from "../assets/linkedin.svg";
import { useTranslation } from "../hooks/useTranslation";

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

  const dialogTransitions = useTransition(isOpen, {
    from: { opacity: 0, y: -10 },
    enter: { opacity: 1, y: 0 },
    leave: { opacity: 0, y: 10 },
    config: config.gentle,
  });

  const overlayTransitions = useTransition(isOpen, {
    from: { opacity: 0 },
    enter: { opacity: 1 },
    leave: { opacity: 0 },
    config: config.gentle,
  });

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
    <Dialog.Root open={isOpen} onOpenChange={onOpenChange}>
      {overlayTransitions((styles: any, item: boolean) =>
        item ? (
          <Dialog.Overlay forceMount asChild>
            <animated.div
              style={{
                opacity: styles.opacity,
              }}
              className="fixed inset-0 bg-black/50 z-50"
            />
          </Dialog.Overlay>
        ) : null
      )}

      {dialogTransitions((styles: any, item: boolean) =>
        item ? (
          <Dialog.Content forceMount asChild>
            <animated.div
              style={styles}
              className="fixed left-1/2 top-1/2 z-50 w-full max-w-2xl -translate-x-1/2 -translate-y-1/2 bg-white max-h-[90dvh] overflow-hidden rounded-lg shadow-lg"
            >
              {/* Header */}
              <div className="p-4 border-b border-gray-200 flex items-center justify-between">
                <Dialog.Title className="text-xl font-semibold text-gray-900">
                  {t("gallery.reviews.reviewTitle")}
                </Dialog.Title>
                <Dialog.Close className="inline-flex items-center justify-center w-8 h-8 rounded-md hover:bg-gray-100 transition-colors">
                  <svg
                    width="15"
                    height="15"
                    viewBox="0 0 15 15"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    className="w-4 h-4"
                  >
                    <path
                      d="m11.7816 4.03157c.0824-.07446.0824-.19618 0-.27064L11.4909 3.46226c-.0746-.07446-.1962-.07446-.2708 0L7.50003 7.1818l-3.71967-3.71954c-.07446-.07446-.19618-.07446-.27064 0L3.21836 3.76092c-.07446.07446-.07446.19618 0 .27064L6.93803 7.75l-3.71967 3.7196c-.07446.0744-.07446.1961 0 .2706l.29135.2913c.07446.0745.19618.0745.27064 0L7.50003 8.3182l3.71967 3.7196c.07446.0745.19618.0745.27064 0l.29135-.2913c.07446-.0745.07446-.1962 0-.2706L8.06203 7.75l3.71957-3.71843Z"
                      fill="currentColor"
                      fillRule="evenodd"
                      clipRule="evenodd"
                    />
                  </svg>
                </Dialog.Close>
              </div>

              {/* Review Content */}
              <div className="p-6 overflow-y-auto max-h-[calc(90vh-200px)]">
                <p className="text-gray-700 text-base leading-relaxed mb-6">
                  {review}
                </p>
              </div>

              {/* Client Information Footer */}
              <ClientInfo />
            </animated.div>
          </Dialog.Content>
        ) : null
      )}
    </Dialog.Root>
  );
};
