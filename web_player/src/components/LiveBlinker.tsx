const LiveBlinker = () => {
  return (
    <div className="flex flex-row items-center space-x-[4px] rounded-full border-[1.5px] border-secondary-100 bg-secondary-100/[0.1] px-[8px] py-[1px] ">
      <div className="relative h-[10px] w-[10px]">
        <div className="absolute h-[9px] w-[9px] rounded-full bg-secondary-100/[0.75]" />
        <div className="absolute  h-[9px] w-[9px] animate-ping rounded-full bg-secondary-100" />
      </div>
      <p className="text-[0.9rem] font-[800] text-secondary-100">LIVE</p>
    </div>
  );
};

export default LiveBlinker;
