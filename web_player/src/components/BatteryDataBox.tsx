import { formatBattery } from "safe/utils/battery.util";
import BatteryIcon from "./BatteryIcon";
import DataBox from "./DataBox";
import useIncidentStore from "safe/stores/incident.store";

const BatteryDataBox = () => {
  const store = useIncidentStore();

  return (
    <DataBox heading="Battery" data={formatBattery(store.incident!.battery)}>
      <div className="mt-[4px]">
        <BatteryIcon color="#5C5C5C" />
      </div>
    </DataBox>
  );
};

export default BatteryDataBox;
