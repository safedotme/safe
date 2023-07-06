import { NextPage } from "next";

const ErrorPage: NextPage = () => {
  return (
    <div className="flex h-[100dvh] items-center justify-center bg-grey-900">
      <div className="mb-[30vh] flex flex-col items-center">
        <img src="error.png" className="h-[80px]" />
        <div className="h-[25px]" />
        <p className=" text-[1.25rem] font-[700] text-white">
          Error Loading Incident
        </p>
        <div className="h-[16px]" />
        <p className=" mx-[35px] text-center text-[0.875rem] font-[400] text-[#B4B5B9]">
          {`This incident has failed to load. This is most likely due to ID next to
          the URL. Check the ID (live.joinsafe.me/{id}) is valid.`}
        </p>
      </div>
    </div>
  );
};

export default ErrorPage;
