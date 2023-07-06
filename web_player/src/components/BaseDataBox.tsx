import useIncidentStore from "safe/stores/incident.store";
import LiveBlinker from "./LiveBlinker";
import { extractMainAddress, removeAddressTag } from "safe/utils/geocoder.util";
import { useEffect, useState } from "react";
import TimeData from "./TimeData";

const BaseDataBox = () => {
  const store = useIncidentStore();

  return (
    <div className="absolute bottom-0 mb-[20px] flex w-full flex-row items-center justify-between px-[16px]">
      <LiveBlinker />
      <div className="flex flex-col items-end">
        <p className="text-[1rem] font-[600] text-white">
          {extractMainAddress(
            removeAddressTag(store.incident?.location.address)
          )}
        </p>
        <TimeData />
      </div>
    </div>
  );
};

export default BaseDataBox;
