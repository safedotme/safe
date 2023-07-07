import { GoogleMap, MarkerF, useLoadScript } from "@react-google-maps/api";
import { mapStylesDark, mapStylesLight } from "safe/assets/map_styles";
import { env } from "safe/env.mjs";
import useIncidentStore from "safe/stores/incident.store";

interface IncidentMapProps {
  isDark: boolean;
}

const IncidentMap = (props: IncidentMapProps) => {
  const script = useLoadScript({
    googleMapsApiKey: env.NEXT_PUBLIC_MAPS_KEY,
  });

  // Initialize Store
  const store = useIncidentStore();

  return !script.isLoaded ? (
    <div />
  ) : (
    <GoogleMap
      mapContainerClassName="map-container"
      center={{
        lat: store.incident == null ? 0 : store.incident.location.lat,
        lng: store.incident == null ? 0 : store.incident.location.long,
      }}
      zoom={17}
      options={{
        disableDefaultUI: true,
        styles: props.isDark ? mapStylesDark : mapStylesLight,
      }}
    >
      <MarkerF
        position={{
          lat: store.incident == null ? 0 : store.incident.location.lat,
          lng: store.incident == null ? 0 : store.incident.location.long,
        }}
        icon={props.isDark ? "pin_dark.svg" : "pin_light.svg"}
      />
    </GoogleMap>
  );
};

export default IncidentMap;
