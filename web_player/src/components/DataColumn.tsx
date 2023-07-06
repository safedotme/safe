import { useEffect, useState } from "react";
import BatteryIcon from "./BatteryIcon";
import DataBox from "./DataBox";
import LocationIcon from "./LocationIcon";
import TimerIcon from "./TimerIcon";
import { getFormattedTimeSinceDate } from "safe/utils/datetime.util";
import useIncidentStore from "safe/stores/incident.store";
import { formatBattery } from "safe/utils/battery.util";

const DataColumn = () => {
  const [duration, setDuration] = useState("");
  const store = useIncidentStore();
  const CONVERSION_COEFF = 3.6;

  useEffect(() => {
    const intervalId = setInterval(() => {
      setDuration(getFormattedTimeSinceDate(store.incident?.datetime));
    }, 1000);
    return () => {
      clearInterval(intervalId);
    };
  });

  return (
    <div className="absolute right-0 top-0 mr-[16px] mt-[22px] flex flex-col items-end space-y-[5px] ">
      <DataBox heading="Battery" data={formatBattery(store.incident!.battery)}>
        <div className="mt-[4px]">
          <BatteryIcon color="#5C5C5C" />
        </div>
      </DataBox>
      <DataBox heading="Duration" data={duration}>
        <div className="mt-[2.5px]">
          <TimerIcon color="#5C5C5C" />
        </div>
      </DataBox>
      <DataBox
        heading="State"
        data={`${(store.incident!.location.speed * CONVERSION_COEFF).toFixed(
          2
        )} KMPH`}
      >
        <div className="mt-[1.5px]">
          <LocationIcon color="#5C5C5C" />
        </div>
      </DataBox>
    </div>
  );
};

export default DataColumn;
