import { formatBattery } from "safe/utils/battery.util";
import BatteryIcon from "./BatteryIcon";
import DataBox from "./DataBox";
import useIncidentStore from "safe/stores/incident.store";

interface BatteryDataBox {
  isDark: boolean;
}

const BatteryDataBox = (props: BatteryDataBox) => {
  const store = useIncidentStore();

  return (
    <DataBox
      heading="Battery"
      data={formatBattery(store.incident!.battery)}
      isDark={props.isDark}
    >
      <div className="mt-[4px]">
        <BatteryIcon color={props.isDark ? "#5C5C5C" : "#8A8A8A"} />
      </div>
    </DataBox>
  );
};

export default BatteryDataBox;
