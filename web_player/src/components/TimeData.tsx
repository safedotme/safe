import { useEffect, useState } from "react";
import useIncidentStore from "safe/stores/incident.store";
import {
  formatTimeFromDate,
  getFormattedTimeSinceDate,
} from "safe/utils/datetime.util";

const TimeData = () => {
  const store = useIncidentStore();
  const [localTime, setLocalTime] = useState("");

  useEffect(() => {
    const intervalId = setInterval(() => {
      setLocalTime(formatTimeFromDate(store.incident?.datetime));
    }, 1000);

    return () => {
      clearInterval(intervalId);
    };
  }, []);

  return (
    <p className="text-[0.875rem] font-[400] text-[#C7C7C7]">
      {`Local Time - ${localTime} ${store.timezone}`}
    </p>
  );
};

export default TimeData;
