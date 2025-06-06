import React from "react";
import PricingCard from "./PricingCard";
import "./PricingSection.css";
import { useTranslation } from "../hooks/useTranslation";

const PricingSection: React.FC = () => {
  const { t } = useTranslation();

  const firstCardFeatures = [
    t("pricing.advertising.features.portal"),
    t("pricing.advertising.features.magazine"),
    t("pricing.advertising.features.banner"),
    t("pricing.advertising.features.social"),
    t("pricing.advertising.features.ads"),
    t("pricing.advertising.features.platforms"),
    t("pricing.advertising.features.research"),
    t("pricing.advertising.features.mailing"),
    t("pricing.advertising.features.youtube"),
  ];

  const firstCardPriceDetails = [
    {
      label: t("pricing.advertising.priceLabel"),
      value: t("pricing.advertising.priceValue"),
    },
  ];

  const secondCardFeatures = [
    t("pricing.fullSupport.features.presentation"),
    t("pricing.fullSupport.features.recommendations"),
    t("pricing.fullSupport.features.directSales"),
    t("pricing.fullSupport.features.comprehensive"),
    t("pricing.fullSupport.features.consulting"),
    t("pricing.fullSupport.features.dueDiligence"),
    t("pricing.fullSupport.features.mediation"),
  ];

  const secondCardPriceDetails = [
    {
      label: t("pricing.fullSupport.commissionLabel"),
      value: t("pricing.fullSupport.commissionValue"),
    },
    {
      label: t("pricing.fullSupport.advanceLabel"),
      value: t("pricing.fullSupport.advanceValue"),
    },
  ];

  return (
    <section className="pricing-section">
      <div className="pricing-container grid lg:grid-cols-2 gap-5">
        <PricingCard
          title={t("pricing.advertising.title")}
          shortDescription={t("pricing.advertising.shortDescription")}
          description={t("pricing.advertising.description")}
          buttonText={t("pricing.advertising.button")}
          buttonVariant="green"
          features={firstCardFeatures}
          priceDetails={firstCardPriceDetails}
          discount={t("pricing.advertising.discount")}
          isMilitaryFree={true}
        />
        <PricingCard
          title={t("pricing.fullSupport.title")}
          shortDescription={t("pricing.fullSupport.shortDescription")}
          description={t("pricing.fullSupport.description")}
          buttonText={t("pricing.fullSupport.button")}
          buttonVariant="red"
          features={secondCardFeatures}
          priceDetails={secondCardPriceDetails}
        />
      </div>
    </section>
  );
};

export default PricingSection;
