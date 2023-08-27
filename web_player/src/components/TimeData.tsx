import { useEffect, useState } from "react";
import useIncidentStore from "safe/stores/incident.store";
import {
  formatTimeFromDate,
  getFormattedTimeSinceDate,
} from "safe/utils/datetime.util";

interface TimeDataProps {
  isDark: boolean;
}

const TimeData = (props: TimeDataProps) => {
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
    <p
      className={`text-[0.875rem]  ${
        props.isDark
          ? "font-[400] text-[#C7C7C7]"
          : "font-[500] text-[#5E5E5E] "
      }`}
    >
      {`Local Time - ${localTime} ${store.timezone}`}
    </p>
  );
};

export default TimeData;
