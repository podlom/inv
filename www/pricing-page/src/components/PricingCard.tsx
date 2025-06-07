import { cn } from "@/lib/utils";
import { Check, ShieldCheck, Store } from "lucide-react";
import React from "react";
import { useTranslation } from "../hooks/useTranslation";

interface PriceDetail {
  label: string;
  value: string;
  icon?: React.ElementType;
  iconColor?: string;
  className?: string;
}

interface PricingCardProps {
  title: string;
  description: string;
  shortDescription: string;
  buttonText: string;
  buttonVariant: "blue" | "red" | "green";
  features: string[];
  priceDetails: PriceDetail[];
  discount?: string;
  isMilitaryFree?: boolean;
  onButtonClick?: () => void;
}
const buttonClasses = {
  blue: "bg-[#3279a0] hover:bg-[#286080]",
  red: "bg-[#c83737] hover:bg-[#a02c2c]",
  green: "bg-[#5fa05f] hover:bg-[#4a8a4a]",
};

const gradientClasses = {
  blue: "bg-[linear-gradient(135deg,#E7F4FD_0%,#FFFFFF_40%)]",
  red: "bg-[linear-gradient(135deg,#FBF2F1_0%,#FFFFFF_40%)]",
  green: "bg-[linear-gradient(135deg,#F1FBF1_0%,#FFFFFF_40%)]",
};

const PricingCard: React.FC<PricingCardProps> = ({
  title,
  description,
  shortDescription,
  buttonText,
  buttonVariant = "blue",
  features,
  priceDetails,
  discount,
  isMilitaryFree,
  onButtonClick,
}) => {
  const { t } = useTranslation();

  // Define data attributes based on button variant
  const getDataAttributes = () => {
    if (buttonVariant === "green") {
      return {
        "data-deal-id": "adv",
        "data-deal-name": "Рекламное продвижение",
        "data-remodal-target": "approach",
      };
    } else if (buttonVariant === "red") {
      return {
        "data-deal-id": "ind",
        "data-deal-name": "Индивидуальный подход",
        "data-remodal-target": "approach",
      };
    }
    return {};
  };

  return (
    <div
      className={cn(
        "border border-[#C7CCD1] rounded-lg p-4 lg:p-6 flex-1 flex flex-col text-left leading-tight",
        gradientClasses[buttonVariant]
      )}
    >
      <div className="lg:min-h-[146px] mb-3">
        <h2 className="font-bold text-2xl mb-1.5">{title}</h2>
        <p className="font-semibold text-base leading-tight mb-1.5">
          {shortDescription}
        </p>
        <p>{description}</p>
      </div>
      <button
        className={cn(
          "py-3 px-5 border-none rounded font-bold text-white cursor-pointer transition-colors mb-6",
          buttonClasses[buttonVariant]
        )}
        onClick={onButtonClick}
        {...getDataAttributes()}
      >
        {buttonText}
      </button>
      <div className="border-t border-[#C7CCD1] -mx-4 lg:-mx-6 pt-5"></div>
      <h3 className="font-bold mb-2">{t("pricing.youWillGet")}</h3>
      <ul className="list-none p-0 mb-6 flex-grow space-y-2">
        {features.map((feature, index) => (
          <li key={index} className=" flex items-start">
            <span className="mr-1.5 flex-shrink-0 inline-flex items-baseline">
              <Check size={20} className="text-black" />
            </span>
            <p className="">{feature}</p>
          </li>
        ))}
      </ul>
      <div className="border-t border-[#C7CCD1] -mx-4 lg:-mx-6 mb-5"></div>

      <div className="flex-1 space-y-8 lg:min-h-[180px] xl:min-h-[172px]">
        <div className="space-y-5">
          {priceDetails.map((detail, index) => (
            <div
              key={index}
              className={cn(
                detail.className || "",
                "whitespace-break-spaces",
                detail.icon && detail.icon !== Check ? "flex items-center" : ""
              )}
            >
              {detail.icon && (
                <span className="w-7 flex-shrink-0 inline-flex items-baseline">
                  <detail.icon
                    size={20}
                    className={
                      detail.icon === Check
                        ? "text-black"
                        : `text-[${detail.iconColor}]`
                    }
                  />
                </span>
              )}
              {detail.label && <p className="font-bold mb-2">{detail.label}</p>}
              <p className={detail.label ? "text-2xl " : "font-bold"}>
                {detail.value}
              </p>
            </div>
          ))}
        </div>
        {(discount || isMilitaryFree) && (
          <div className="mt-3">
            {discount && (
              <div className="mt-3 flex items-center">
                <span className="w-7 flex-shrink-0 inline-flex items-baseline">
                  <Store size={20} className="" />
                </span>
                <p className="font-medium ">{discount}</p>
              </div>
            )}

            {isMilitaryFree && (
              <div className="mt-2 flex items-center">
                <span className="w-7 flex-shrink-0 inline-flex items-baseline">
                  <ShieldCheck size={20} className="" />
                </span>
                <p className="font-medium ">
                  {t("pricing.advertising.militaryFree")}
                </p>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default PricingCard;
