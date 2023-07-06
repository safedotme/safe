import useIncidentStore from "safe/stores/incident.store";
import LiveBlinker from "./LiveBlinker";
import { extractMainAddress, removeAddressTag } from "safe/utils/geocoder.util";

const BaseDataBox = () => {
  const store = useIncidentStore();

  return (
    <div className="absolute bottom-0 mb-[20px] flex w-full flex-row items-center justify-between px-[16px]">
      <LiveBlinker />
      <div className="flex flex-col items-end">
        <p className="text-[1rem] font-[500] text-white">
          {extractMainAddress(
            removeAddressTag(store.incident?.location.address)
          )}
        </p>
        <p className="text-[0.875rem] font-[400] text-[#C7C7C7]">
          09:41 - 13:12 CST
        </p>
      </div>
    </div>
  );
};

export default BaseDataBox;
