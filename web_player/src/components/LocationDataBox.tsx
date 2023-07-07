import useIncidentStore from "safe/stores/incident.store";
import DataBox from "./DataBox";
import LocationIcon from "./LocationIcon";

const LocationDataBox = () => {
  const store = useIncidentStore();
  const CONVERSION_COEFF = 3.6;

  return (
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
  );
};

export default LocationDataBox;
