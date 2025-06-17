import React, { useMemo } from "react";
import { Gallery, type ReviewItem } from "./blocks/gallery";
import { useTranslation } from "../hooks/useTranslation";
import { useReviews } from "../hooks/useReviews";
import reviewsBg from "../assets/reviews-bg.svg";

// Define the structure of the fallback review data
interface FallbackReviewData {
  id: number;
  fullName: string;
  company: string;
  job: string;
  text: string;
  imageUrl: string;
  facebookUrl?: string;
  linkedinUrl?: string;
}

// Define the structure of window.reviewsData (if it follows a different format)
interface WindowReviewData {
  id: string | number;
  name?: string;
  fullName?: string;
  title?: string;
  company?: string;
  job?: string;
  review?: string;
  text?: string;
  profileImage?: string;
  imageUrl?: string;
  linkedinUrl?: string;
  facebookUrl?: string;
}

// Fallback review data
const fallbackReviews: FallbackReviewData[] = [
  {
    id: 34,
    fullName: "Олександр Франко",
    company: "Gostomel warehouse",
    job: "Співвласник",
    text: "Висловлюю вдячність компанії InVenture та її керівнику Олексію Олейнікову за сприяння у продажі нашого складського комплексу. Незважаючи на те, що період реалізації нерухомості затягнувся на декілька років, зі сторони брокерів була здійснена величезна робота з пошуку покупців, організації переглядів об'єкту, узгодження позицій сторін та супроводження угоди.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2025/05/franko-1.jpg",
    facebookUrl: "https://www.facebook.com/oleksandr.franko.5",
    linkedinUrl: "",
  },
  {
    id: 33,
    fullName: "Сергій Ольховський",
    company: "Magisto",
    job: "Власник",
    text: "Щиро висловлюю слова вдячності компанії InVenture і особисто Олексію Олейнікову за якісну допомогу з продажу виробничого (кондитерського) підприємства в дивовижно стислі терміни в непростий для всіх нас час. Якісна реклама, професійний підхід, компетентний відбір потенційних покупців – все це дало найліпший результат. Сподіваюсь на сталі ділові стосунки і подальшу плідну співпрацю в наступних проектах.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2025/04/olkhovsky.jpg",
    facebookUrl: "",
    linkedinUrl: "",
  },
  {
    id: 32,
    fullName: "Сергій Міщенко",
    company: "ILTA",
    job: "Власник",
    text: 'ТОВ "ІЛТА" виражає компанії InVenture велику подяку за всебічну допомогу у реалізації продажу обʼєкту нерухомості. Завдяки Вам, а особливо Пану Олексію Олейнікову, завдяки публікації на порталі та супроводу в подальшому, всі зацікавлені сторони залишились задоволені. Бажаємо подальших успіхів у Вашій діяльності та сподіваємось на подальшу плідну співпрацю.',
    imageUrl: "https://inventure.ua/wp-content/uploads/2024/08/mishenko.jpg",
    facebookUrl: "",
    linkedinUrl: "",
  },
  {
    id: 30,
    fullName: "Мстислав Скоробогатов",
    company: "Машиностроительный завод «Старт»",
    job: "Собственник",
    text: "Спасибо ребятам, что помогли найти покупателя и продать комплекс недвижимости в Катюжанке. Осознавая всю сложность продажи промышленной недвижимости в Украине и нюансы по объекту, InVenture справились на 5 баллов, хотя сам процесс затянулся на несколько лет. Более 30 потенциальных покупателей рассматривали возможность приобретения и таки нашелся тот самый, с которым мы закрыли сделку.",
    imageUrl:
      "https://inventure.ua/wp-content/uploads/2023/02/skorobogatov.jpg",
    facebookUrl: "https://www.facebook.com/mstyslav.skorobogatov",
    linkedinUrl: "",
  },
  {
    id: 5,
    fullName: "Константин Пивень",
    company: "Roshen",
    job: "Директор",
    text: "«Мы благодарим нашего советника по сделке, компанию InVenture, которая оказала профессиональную поддержку по вопросам поиска и подбора инвестиционно-привлекательных активов, а также комплексно сопроводили непосредственно процесс приобретения агрокомпании в Хмельницкой области. Наши стратегические планы предусматривают дальнейшую экспансию в сельскохозяйственной сфере и мы с удовольствием продолжим сотрудничество с InVenture по вопросам приобретения новых агрокактивов».",
    imageUrl:
      "https://inventure.ua/wp-content/uploads/2019/04/piven-konstantin.jpg",
    facebookUrl: "https://www.facebook.com/konstantin.piven.9",
    linkedinUrl: "https://www.linkedin.com/in/konstantin-p-76b99a27/",
  },
  {
    id: 2,
    fullName: "Руслана Пособчук",
    company: "Droozi",
    job: "Cобственник бизнеса",
    text: "Прежде, чем размещать объявление по продаже нашего бизнеса, мы промониторили другие порталы — InVenture особенно выделился. Легкий, понятный, сжатый, удобный в пользовании и стильный сайт. Так же при выборе сыграло роль и наличие англоязычной версии — с нами связывались иностранцы. В итоге мы продали свой бизнес через этот портал спустя полгода. Довольны профессионализмом команды.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2019/02/ruslana.jpg",
    facebookUrl: "https://www.facebook.com/posobchuk",
    linkedinUrl: "",
  },
  {
    id: 26,
    fullName: "Александр Шульга",
    company: "Fozzy-Agro",
    job: "Managing Director",
    text: "Знаем и уважаем компанию InVenture как надежных партнеров и лучших профессионалов в сделках M&A в сфере агробизнеса. Уже более 3х лет мы успешно сотрудничаем с ними по нашей программе расширения земельного банка и всегда получали качественные и актуальные предложения для потенциальных сделок. На сегодня мы уже совместно с InVenture закрыли 2 сделки по покупке агрокомпаний в Украине. Мы благодарны партнерам InVenture за качественное сопровождение сделок с всегда положительным результатом!",
    imageUrl: "https://inventure.ua/wp-content/uploads/2020/12/shulga-a.jpg",
    facebookUrl: "https://www.facebook.com/aleksandr.shulga.92",
    linkedinUrl: "",
  },
  {
    id: 1,
    fullName: "Наталия Бобро",
    company: "Release Education",
    job: "Cобственник бизнеса",
    text: "Решила обратиться в компанию InVenture по продаже своего действующего бизнеса, детской образовательной студии Release. Учитывая, что в данный бизнес за 12 лет было вложено довольно много инвестиций, а компания позиционируется как лидер рынка в премиуме сегменте образования, хотелось довериться профессионалам. Ребята не подвели, оперативно сработали по поиску покупателей, с одним из которых удалось закрыть сделку. Рекомендую довериться InVenture как надежному, понимающему партнеру для продажи своего бизнеса.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2019/09/bobro-nata.jpg",
    facebookUrl: "https://www.facebook.com/natalia.bobro",
    linkedinUrl: "https://www.linkedin.com/in/natalia-bobro-139005132/",
  },
  {
    id: 9,
    fullName: "Елена Березовская",
    company: "Органик Эра",
    job: "Учредитель",
    text: "Я признательна компании InVenture, которая в непростое для компании время помогла привлечь инвестора в долю 50% ТД «Органик Эра» для дальнейшего развития бизнеса. Индивидуальный подход и глубокое погружение в специфику деятельности, нахождение инвестора и поддержка в переговорном процессе, а также юридическое сопровождение сделки – это то, что я оценила в работе с InVenture. ",
    imageUrl:
      "https://inventure.ua/wp-content/uploads/2019/11/berezovska-olena.jpg",
    facebookUrl: "https://www.facebook.com/olenaorganic",
    linkedinUrl: "",
  },
  {
    id: 31,
    fullName: "Андрей Горбатюк",
    company: "BGV Group Management",
    job: "Project Manager",
    text: "Сотрудничали с компанией Inventure, по реализации бизнес актива, связанного с деревоперерабатывающей промышленностью. Хочу отметить уровень профессионализма в поиске покупателя и организации бизнес коммуникации в процессе проведения сделки. Все четко, своевременно и грамотно , даже в условиях активной фазы боевых действий.\r\nБольшая благодарность Алексею Олейникову, работать с Вами - одно удовольствие!",
    imageUrl:
      "https://inventure.ua/wp-content/uploads/2023/03/no-picture-available-icon-20-300x300.png",
    facebookUrl: "",
    linkedinUrl: "https://www.linkedin.com/in/andrey-horbatyuk-17635a114",
  },
  {
    id: 23,
    fullName: "Ирина Мышкова",
    company: "Active Child School",
    job: "Собственник",
    text: "Благодаря рекламе InVenture нам удалось довольно быстро найти покупателя на частный детский сад «Active Child School».\r\nСобираемся и дальше продолжать развивать сеть, продвигая франшизу на инвестиционном портале и рассчитывать на поддержку InVenture в привлечении инвестиций и продаже наших готовых проектов.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2020/02/Mushkova.jpg",
    facebookUrl: "",
    linkedinUrl:
      "https://www.linkedin.com/in/%D0%B8%D1%80%D0%B8%D0%BD%D0%B0-%D0%BC%D1%8B%D1%88%D0%BA%D0%BE%D0%B2%D0%B0-68b502147/",
  },
  {
    id: 6,
    fullName: "Андрей Твердохлеб",
    company: "Компания «Агромир»",
    job: "Президент",
    text: "Имею опыт сотрудничества с компанией InVenture в части приобретения агропромышленных компаний более 3 лет. Сплоченная команда, углубленная экспертиза в части поиска и подбора агроактивов в Украине, оперативность в предоставлении информации для принятия решений, а также помощь в процессе медиации с собственниками агробизнеса выделяет InVenture среди других участников рынка. Рекомендую данную компанию как профессионального игрока на рынке купли-продажи агробизнеса в Украине.",
    imageUrl:
      "https://inventure.ua/wp-content/uploads/2019/04/3130161_w640_h640_7-momentov-vybora.jpg",
    facebookUrl: "",
    linkedinUrl: "",
  },
  {
    id: 4,
    fullName: "Василий Решетов",
    company: 'НПО "Термосистемы"',
    job: "Cобственник",
    text: "«Солнечная электроэнергетика для нас — приоритетное направление. Мы долго присматривались и анализировали возможные варианты входа на этот рынок. Благодаря компании InVenture мы смогли подобрать участок, который наиболее соответствовал нашим критериям, отсеяв другие нерелевантные предложения. Хотелось бы отдельно отметить компетентность InVenture в сфере альтернативной энергетики. Сделка прошла быстро, прозрачно и комфортно для каждой из сторон. Надеемся на дальнейшее плодотворное сотрудничество».",
    imageUrl: "https://inventure.ua/wp-content/uploads/2019/09/reshetov.jpg",
    facebookUrl: "https://www.facebook.com/profile.php?id=100002004997565",
    linkedinUrl: "",
  },
  {
    id: 3,
    fullName: "Олег Оболенцев",
    company: "Central Park Spa",
    job: "Cобственник бизнеса",
    text: "Никогда бы не подумал, что можно в течение двух недель продать салон красоты. Скорее это, как дело случая, так профессиональный подход ребят из InVenture. Приятно было иметь дело. Привели двух покупателей, один из них в итоге купил бизнес. Благодарен за то, что решили вопрос оперативно.",
    imageUrl: "https://inventure.ua/wp-content/uploads/2019/04/obolentsev.jpg",
    facebookUrl: "https://www.facebook.com/olegeurobotsky",
    linkedinUrl: "",
  },
];

// Function to transform review data to ReviewItem format
const transformReviewData = (
  data: WindowReviewData | FallbackReviewData
): ReviewItem => {
  // Handle both window.reviewsData format and fallback format
  const id = String(data.id);
  const name =
    ("name" in data && data.name) ||
    ("fullName" in data && data.fullName) ||
    "Unknown";
  const title =
    ("title" in data && data.title) || ("job" in data && data.job) || "";
  const review =
    ("review" in data && data.review) || ("text" in data && data.text) || "";
  const profileImage =
    ("profileImage" in data && data.profileImage) ||
    ("imageUrl" in data && data.imageUrl) ||
    "";
  const subtitle = "company" in data ? `${data.company}` : "";

  return {
    id,
    name,
    title,
    subtitle,
    review,
    profileImage,
    linkedinUrl: data.linkedinUrl || "",
    facebookUrl: data.facebookUrl || "",
  };
};

export const ReviewsSection: React.FC = () => {
  const { t } = useTranslation();
  const {
    reviews,
    loading: reviewsLoading,
    error: reviewsError,
  } = useReviews();

  // Map fallback reviews from raw API format to ReviewItem format
  const fallbackReviewsFormatted = useMemo(() => {
    return fallbackReviews.map(transformReviewData);
  }, []);

  const reviewsData = useMemo(() => {
    // If there's an error or no reviews from API, use fallback
    if (reviewsError || !reviews.length) {
      return fallbackReviewsFormatted;
    }
    return reviews;
  }, [reviews, reviewsError, fallbackReviewsFormatted]);

  return (
    <div className="relative">
      <img
        src={reviewsBg}
        alt="Reviews background"
        className="absolute z-0 top-0 left-1/2 -translate-x-1/2 h-full object-cover"
      />
      <div className="z-10 relative mx-auto pb-16 pt-16 lg:pt-24">
        <Gallery
          title={t("gallery.reviews.title")}
          description={t("gallery.reviews.description")}
          type="reviews"
          data={reviewsData}
          loading={reviewsLoading}
        />
      </div>
    </div>
  );
};
