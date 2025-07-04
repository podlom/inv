import { useMediaQuery } from "@/hooks/useMediaQuery";
import { motion } from "motion/react";
import { useTranslation } from "../../hooks/useTranslation";
import { CustomBentoGrid } from "./hero-bento-grid";

export const Hero = () => {
  const { t } = useTranslation();
  const isMobile = useMediaQuery("(max-width: 1023px)");

  const scrollToPricing = () => {
    const pricingSection = document.getElementById("pricing");
    if (pricingSection) {
      pricingSection.scrollIntoView({
        behavior: "smooth",
        block: "start",
      });
    }
  };

  return (
    <div className="pt-[4rem] ">
      <div className="container  w-full flex flex-col items-center">
        <motion.h1
          initial={{ opacity: 0, y: 70 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{
            delay: 0.3,
            duration: 0.8,
            ease: "easeInOut",
          }}
          className="bg-gradient-to-br from-sky-900 to-sky-900 py-4 bg-clip-text text-center text-3xl font-medium tracking-tight text-transparent md:text-5xl"
        >
          {t("hero.title")
            .split("\n")
            .map((line, index) => (
              <span key={index}>
                {line}
                {index < t("hero.title").split("\n").length - 1 && <br />}
              </span>
            ))}
        </motion.h1>
        {isMobile ? (
          <button
            onClick={scrollToPricing}
            className="cursor-pointer mt-8 min-h-12 shadow-[0_4px_14px_0_rgb(50,121,160,39%)] hover:shadow-[0_6px_20px_rgba(50,121,160,50%)] px-6 py-2 rounded-md text-white font-bold transition duration-200 ease-linear bg-[#3279a0]"
          >
            {t("hero.button")}
          </button>
        ) : (
          <motion.button
            initial={{ opacity: 0, y: 70 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{
              delay: 0.8,
              duration: 0.8,
              ease: "easeInOut",
            }}
            onClick={scrollToPricing}
            className="cursor-pointer mt-8 min-h-12 shadow-[0_4px_14px_0_rgb(50,121,160,39%)] hover:shadow-[0_6px_20px_rgba(50,121,160,50%)] px-6 py-2  rounded-md text-white font-bold transition duration-200 ease-linear bg-[#3279a0]"
          >
            {t("hero.button")}
          </motion.button>
        )}

        <CustomBentoGrid className="w-full mt-12 lg:mt-0" />
      </div>
    </div>
  );
};
