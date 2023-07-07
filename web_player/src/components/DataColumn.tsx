import { useEffect, useState } from "react";
import DataBox from "./DataBox";
import TimerIcon from "./TimerIcon";
import { getFormattedTimeSinceDate } from "safe/utils/datetime.util";
import BatteryDataBox from "./BatteryDataBox";
import LocationDataBox from "./LocationDataBox";
import useIncidentStore from "safe/stores/incident.store";

interface DataColumnProps {
  isDark: boolean;
}

const DataColumn = (props: DataColumnProps) => {
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
      <BatteryDataBox isDark={props.isDark} />
      <DataBox heading="Duration" data={duration} isDark={props.isDark}>
        <div className="mt-[2.5px]">
          <TimerIcon color={props.isDark ? "#5C5C5C" : "#8A8A8A"} />
        </div>
      </DataBox>
      <LocationDataBox isDark={props.isDark} />
    </div>
  );
};

export default DataColumn;
