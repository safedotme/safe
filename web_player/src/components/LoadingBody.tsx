import Loader from "./Loader";

const LoadingBody = () => {
  return (
    <div className="absolute left-0 top-0 flex h-full w-screen items-center bg-grey-900">
      <div className="mb-[30vh] flex flex-col items-center">
        <Loader />
        <div className="h-[25px]" />
        <p className=" text-[1.25rem] font-[700] text-white">
          Loading Incident
        </p>
        <div className="h-[16px]" />
        <p className=" mx-[35px] text-center text-[0.875rem] font-[400] text-[#B4B5B9]">
          {`We're loading a stream of the incident to your device. This shouldn't
          take more than a minute.`}
          <br />
          <br />⚠ NOTE: Emergency services (ie, 911) have not been notified.
        </p>
      </div>
    </div>
  );
};

export default LoadingBody;
