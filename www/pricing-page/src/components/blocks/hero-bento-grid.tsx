import type { ReactNode } from "react";

import { cn } from "@/lib/utils";
import { useTranslation } from "../../hooks/useTranslation";
// Import SVG backgrounds
import leftBg from "../../assets/bento-bg/left.svg";
import rightBg from "../../assets/bento-bg/right.svg";
import leftCenterBottomBg from "../../assets/bento-bg/left-center-bottom.svg";
import leftCenterTopBg from "../../assets/bento-bg/left-center-top.svg";
import rightCenterBottomBg from "../../assets/bento-bg/right-center-bottom.svg";
import rightCenterTopBg from "../../assets/bento-bg/right-center-top.svg";

// Import small SVG backgrounds for responsive design
import leftBgSm from "../../assets/bento-bg-sm/left.svg";
import rightBgSm from "../../assets/bento-bg-sm/right.svg";
import leftCenterBottomBgSm from "../../assets/bento-bg-sm/left-center-bottom.svg";
import leftCenterTopBgSm from "../../assets/bento-bg-sm/left-center-top.svg";
import rightCenterBottomBgSm from "../../assets/bento-bg-sm/right-center-bottom.svg";
import rightCenterTopBgSm from "../../assets/bento-bg-sm/right-center-top.svg";

const BentoGrid = ({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) => {
  return (
    <div
      className={cn(
        "grid w-full auto-rows-[22rem] grid-cols-3 gap-4",
        className
      )}
    >
      {children}
    </div>
  );
};

const BentoCard = ({
  className,
  background,
  backgroundSm,
  children,
  position = "left-top",
}: {
  className: string;
  background: ReactNode;
  backgroundSm?: ReactNode;
  children: ReactNode;
  position?: "left-top" | "left-center" | "center";
}) => (
  <div
    className={cn(
      "group relative col-span-3 flex flex-col justify-between overflow-hidden rounded-xl",
      // light styles
      // "bg-white [box-shadow:0_0_0_1px_rgba(0,0,0,.03),0_2px_4px_rgba(0,0,0,.05),0_12px_24px_rgba(0,0,0,.05)]",
      // dark styles
      "transform-gpu ",
      className
    )}
  >
    {/* Desktop background */}
    <div className="hidden lg:block">{background}</div>
    {/* Mobile/Tablet background */}
    <div className="block lg:hidden">{backgroundSm || background}</div>
    <div
      className={cn(
        "flex-1 pointer-events-none z-10 flex transform-gpu flex-col gap-1 px-4 lg:px-6 transition-all duration-300 ",
        // "group-hover:-translate-y-2",
        position === "left-top" &&
          " lg:justify-start lg:items-start lg:py-[28px]",
        position === "left-center" && "justify-center items-start",
        position === "center" &&
          " lg:justify-center lg:items-center lg:text-center",
        // Responsive positioning - all cards use justify-center items-start on mobile/tablet
        "max-lg:justify-center max-lg:items-start max-lg:text-left"
      )}
    >
      {children}
    </div>
  </div>
);

const CustomBentoGrid = ({ className }: { className?: string }) => {
  const { t } = useTranslation();

  return (
    <div className={cn(className)}>
      {/* Desktop grid */}
      <div
        className="hidden lg:grid grid-cols-4 gap-6 h-[400px]"
        style={{ gridTemplateRows: "auto auto 136px 136px" }}
      >
        {/* Left area - spans all rows, first column */}
        <BentoCard
          className="row-span-4 col-span-1"
          background={
            <img
              src={leftBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-3xl space-x-1">
              <span>{t("bentoGrid.experience.value")}</span>
              <span className="text-2xl">{t("bentoGrid.experience.unit")}</span>
            </p>
            <p className="max-w-lg leading-tight ">
              {t("bentoGrid.experience.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Left-center-top area - row 3, column 2 */}
        <BentoCard
          className="row-start-3 row-span-1 col-start-2 col-span-1"
          position="left-center"
          background={
            <img
              src={leftCenterTopBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-3xl space-x-1">
              <span>{t("bentoGrid.dealsValue.value")}</span>
              <span className="text-2xl">{t("bentoGrid.dealsValue.unit")}</span>
            </p>
            <p className="max-w-lg leading-tight">
              {t("bentoGrid.dealsValue.description")
                .split("\n")
                .map((line, index) => (
                  <span key={index}>
                    {line}
                    {index <
                      t("bentoGrid.dealsValue.description").split("\n").length -
                        1 && <br />}
                  </span>
                ))}
            </p>
          </h2>
        </BentoCard>

        {/* Right-center-top area - row 3, column 3 */}
        <BentoCard
          className="row-start-3 row-span-1 col-start-3 col-span-1"
          position="center"
          background={
            <img
              src={rightCenterTopBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold pt-2">
            <p className="text-3xl font-bold">
              {t("bentoGrid.visitors.value")}
            </p>
            <p className="max-w-lg leading-tight ">
              {t("bentoGrid.visitors.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Right area - spans all rows, last column */}
        <BentoCard
          className="row-span-4 col-span-1"
          background={
            <img
              src={rightBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-3xl ">{t("bentoGrid.subscribers.value")}</p>
            <p className="max-w-lg leading-tight ">
              {t("bentoGrid.subscribers.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Left-center-bottom area - row 4, column 2 */}
        <BentoCard
          className="row-start-4 row-span-1 col-start-2 col-span-1"
          background={
            <img
              src={leftCenterBottomBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
          position="left-center"
        >
          <h2 className="text-white font-bold">
            <p className="text-3xl  ">{t("bentoGrid.dealsCount.value")}</p>
            <p className="max-w-lg leading-tight ">
              {t("bentoGrid.dealsCount.description")
                .split("\n")
                .map((line, index) => (
                  <span key={index}>
                    {line}
                    {index <
                      t("bentoGrid.dealsCount.description").split("\n").length -
                        1 && <br />}
                  </span>
                ))}
            </p>
          </h2>
        </BentoCard>

        {/* Right-center-bottom area - row 4, column 3 */}
        <BentoCard
          className="row-start-4 row-span-1 col-start-3 col-span-1"
          background={
            <img
              src={rightCenterBottomBg}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
          position="center"
        >
          <h2 className="text-white font-bold">
            <p className="text-3xl  ">{t("bentoGrid.investorBase.value")}</p>
            <p className="max-w-lg leading-tight ">
              {t("bentoGrid.investorBase.description")}
            </p>
          </h2>
        </BentoCard>
      </div>

      {/* Mobile/Tablet grid - up to 1024px */}
      <div className="lg:hidden grid grid-cols-2 sm:grid-cols-2 gap-4">
        {/* Left card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={leftBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl">
              {t("bentoGrid.experience.value")}
              <span className="text-xl">{t("bentoGrid.experience.unit")}</span>
            </p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.experience.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Right card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={rightBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl">{t("bentoGrid.subscribers.value")}</p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.subscribers.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Left-center-top card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={leftCenterTopBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl">
              {t("bentoGrid.dealsValue.value")}
              <span className="text-xl">{t("bentoGrid.dealsValue.unit")}</span>
            </p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.dealsValue.description").replace("\n", " ")}
            </p>
          </h2>
        </BentoCard>

        {/* Right-center-top card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={rightCenterTopBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl font-bold">
              {t("bentoGrid.visitors.value")}
            </p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.visitors.description")}
            </p>
          </h2>
        </BentoCard>

        {/* Left-center-bottom card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={leftCenterBottomBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl">{t("bentoGrid.dealsCount.value")}</p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.dealsCount.description").replace("\n", " ")}
            </p>
          </h2>
        </BentoCard>

        {/* Right-center-bottom card */}
        <BentoCard
          className="h-[140px] w-full  sm:col-span-1 col-span-2"
          background={
            <img
              src={rightCenterBottomBgSm}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
            />
          }
        >
          <h2 className="text-white font-bold">
            <p className="text-2xl">{t("bentoGrid.investorBase.value")}</p>
            <p className="text-sm leading-tight">
              {t("bentoGrid.investorBase.description")}
            </p>
          </h2>
        </BentoCard>
      </div>
    </div>
  );
};

export { BentoCard, BentoGrid, CustomBentoGrid };
