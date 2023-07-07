import { useEffect, useState } from "react";
import DataBox from "./DataBox";
import TimerIcon from "./TimerIcon";
import { getFormattedTimeSinceDate } from "safe/utils/datetime.util";
import BatteryDataBox from "./BatteryDataBox";
import LocationDataBox from "./LocationDataBox";
import useIncidentStore from "safe/stores/incident.store";

const DataColumn = () => {
  const [duration, setDuration] = useState("");
  const store = useIncidentStore();

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
      <BatteryDataBox />
      <DataBox heading="Duration" data={duration}>
        <div className="mt-[2.5px]">
          <TimerIcon color="#5C5C5C" />
        </div>
      </DataBox>
      <LocationDataBox />
    </div>
  );
};

export default DataColumn;
