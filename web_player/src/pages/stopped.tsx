import { NextPage } from "next";

const StoppedPage: NextPage = () => {
  return (
    <div className="flex h-[100dvh] items-center justify-center bg-grey-900">
      <div className="mb-[30dvh] flex flex-col items-center">
        <img src="stopped.png" className="h-[80px]" />
        <div className="h-[25px]" />
        <p className=" text-[1.25rem] font-[700] text-white">
          The Incident has Ended
        </p>
        <div className="h-[16px]" />
        <p className=" mx-[35px] text-center text-[0.875rem] font-[400] text-[#B4B5B9]">
          {`The user has stopped capturing the incident. As an emergency contact,
          you will receive an SMS message the user's final information shortly.`}
        </p>
      </div>
    </div>
  );
};

export default StoppedPage;
