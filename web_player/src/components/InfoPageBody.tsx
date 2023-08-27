import { useEffect, useState } from "react";

interface InfoPageBody {
  header: string;
  body: string;
  image: string;
}

const InfoPageBody = (props: InfoPageBody) => {
  const [isDark, setIsDark] = useState(false);

  useEffect(() => {
    // Set theme
    const theme = window.matchMedia("(prefers-color-scheme: dark)");
    if (theme.matches) {
      setIsDark(true);
    }
  }, []);

  return (
    <div className={`flex h-[100dvh] items-center justify-center `}>
      <div className="mb-[30dvh] flex flex-col items-center">
        <img
          src={`${props.image}_${isDark ? "dark" : "light"}.png`}
          className="h-[80px]"
        />
        <div className="h-[25px]" />
        <p
          className={`text-[1.25rem] font-[700] ${
            isDark ? "text-white" : "text-[#373737]"
          }`}
        >
          {props.header}
        </p>
        <div className="h-[16px]" />
        <p
          className={`mx-[35px] text-center text-[0.875rem] font-[400]  ${
            isDark ? "text-[#B4B5B9]" : "text-[#5E5E5E]"
          }`}
        >
          {props.body}
        </p>
      </div>
    </div>
  );
};

export default InfoPageBody;
