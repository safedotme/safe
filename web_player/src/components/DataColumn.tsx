import BatteryIcon from "./BatteryIcon";
import DataBox from "./DataBox";
import LocationIcon from "./LocationIcon";
import TimerIcon from "./TimerIcon";

const DataColumn = () => {
  return (
    <div className="absolute right-0 top-0 mr-[16px] mt-[22px] flex flex-col items-end space-y-[5px] ">
      <DataBox heading="Battery" data="89% (HIGH)">
        <div className="mt-[4px]">
          <BatteryIcon color="#5C5C5C" />
        </div>
      </DataBox>
      <DataBox heading="Duration" data="00:09:11">
        <div className="mt-[2.5px]">
          <TimerIcon color="#5C5C5C" />
        </div>
      </DataBox>
      <DataBox heading="State" data="30kmph">
        <div className="mt-[1.5px]">
          <LocationIcon color="#5C5C5C" />
        </div>
      </DataBox>
    </div>
  );
};

export default DataColumn;
