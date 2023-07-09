import useIncidentStore from "safe/stores/incident.store";
import DataBox from "./DataBox";
import LocationIcon from "./LocationIcon";

interface LocationDataBox {
  isDark: boolean;
}

const LocationDataBox = (props: LocationDataBox) => {
  const store = useIncidentStore();
  const CONVERSION_COEFF = 3.6;

  return (
    <DataBox
      heading="State"
      isDark={props.isDark}
      data={`${
        store.incident!.location.speed * CONVERSION_COEFF > 2
          ? "MOVING"
          : "STATIONARY"
      }`}
    >
      <div className="mt-[1.5px]">
        <LocationIcon color={props.isDark ? "#5C5C5C" : "#8A8A8A"} />
      </div>
    </DataBox>
  );
};

export default LocationDataBox;
