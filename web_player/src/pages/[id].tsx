import { NextPage } from "next";
import { useRouter } from "next/router";
import { getFirestore } from "firebase/firestore";
import { getApp } from "firebase/app";
import incidentListen from "safe/services/firestore.service";
import useIncidentStore from "safe/stores/incident.store";
import { useEffect, useState } from "react";
import IncidentMap from "safe/components/IncidentMap";
import GradientOverlay from "safe/components/GradientOverlay";
import BaseDataBox from "safe/components/BaseDataBox";
import DataColumn from "safe/components/DataColumn";
import dynamic from "next/dynamic";
import { Stream } from "safe/models/incident.model";
import { clearTimeout } from "timers";
import { fetchTimezoneFromCoordinates } from "safe/services/timezone.service";
const VideoStream = dynamic(() => import("safe/components/VideoStream"), {
  ssr: false,
});

const IncidentPage: NextPage = () => {
  // Initialize Router
  const router = useRouter();

  // Initialize Store
  const store = useIncidentStore();

  // Local State
  const [stream, setStream] = useState<Stream | null>(null);
  const [isDark, setIsDark] = useState(false);

  // Initialize Firestore

  useEffect(() => {
    // Set theme
    const theme = window.matchMedia("(prefers-color-scheme: dark)");
    if (theme.matches) {
      setIsDark(true);
    }

    // Initialize Incident
    if (!router.isReady) return;
    let fetchedTimezone = false;

    const db = getFirestore(getApp());

    incidentListen({
      db: db,
      id: router.query.id as string,
      onFetch: (incident) => {
        store.setIncident(incident);

        if (!store.fetched) {
          store.setFetched(true);
          setStream(incident.stream);
        }

        if (!fetchedTimezone) {
          fetchedTimezone = true;

          fetchTimezoneFromCoordinates(
            incident.location.lat,
            incident.location.long,
            incident.datetime
          )
            .then((timezone) => {
              store.setTimezone(timezone);
            })
            .catch((err) => {
              console.log(err);
            });
        }
      },
      onError: (error) => {
        if (error.toLowerCase().includes("insufficient permissions")) {
          void router.push("/stopped");
          return;
        }

        void router.push("/error");
      },
    });
  }, [router.isReady]);

  return (
    <div className="relative h-[100dvh] w-screen">
      <div className={`absolute left-0 top-0 h-[100dvh] w-screen`}>
        {store.fetched ? <IncidentMap isDark={isDark} /> : <div />}
      </div>
      <GradientOverlay isDark={isDark} />
      {store.fetched ? <BaseDataBox isDark={isDark} /> : <div />}
      {store.fetched ? <DataColumn isDark={isDark} /> : <div />}
      {store.fetched && stream != null ? (
        <VideoStream stream={stream} isDark={isDark} />
      ) : (
        <div />
      )}
    </div>
  );
};

export default IncidentPage;
