import LiveBlinker from "./LiveBlinker";

const BaseDataBox = () => {
  return (
    <div className="absolute bottom-0 mb-[20px] flex w-full flex-row items-center justify-between px-[16px]">
      <LiveBlinker />
      <div className="h-[20px] w-[30px] bg-white"></div>
    </div>
  );
};

export default BaseDataBox;
