import { NextPage } from "next";
import { useRouter } from "next/router";
import { getFirestore } from "firebase/firestore";
import { getApp } from "firebase/app";
import incidentListen from "safe/services/firestore.service";
import useIncidentStore from "safe/stores/incident.store";
import { useEffect } from "react";
import LoadingBody from "safe/components/LoadingBody";
import IncidentMap from "safe/components/IncidentMap";

const IncidentPage: NextPage = () => {
  // Initialize Router
  const router = useRouter();

  // Initialize Store
  const store = useIncidentStore();

  // Initialize Firestore

  useEffect(() => {
    if (!router.isReady) return;

    const db = getFirestore(getApp());

    incidentListen({
      db: db,
      id: router.query.id as string,
      onFetch: (incident) => {
        // Add a wait to give users time to read description | wait for at least 5 seconds

        store.setIncident(incident);
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
    <div className="relative h-screen w-screen">
      <div className="absolute left-0 top-0 h-screen w-screen bg-grey-900">
        <IncidentMap />
      </div>
      <div className="absolute bottom-0 h-[150px] w-screen bg-gradient-to-t from-grey-700 from-20% to-grey-700/[0] to-100%" />

      <div className="hidden opacity-[0]">
        <LoadingBody />
      </div>
    </div>
  );
};

export default IncidentPage;
