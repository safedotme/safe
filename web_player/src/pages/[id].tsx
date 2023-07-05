import { NextPage } from "next";
import { useRouter } from "next/router";
import { doc, getDoc, getFirestore } from "firebase/firestore";
import { getApp } from "firebase/app";
import incidentListen from "safe/services/firestore.service";
import Loader from "safe/components/loader/loader";

const IncidentPage: NextPage = () => {
  // Initialize Router
  const router = useRouter();

  // Initialize Firestore
  const db = getFirestore(getApp());
  incidentListen({
    db: db,
    id: router.query.id as string,
    onFetch: (incident) => {
      console.log(incident.stream.userId);
    },
    onError: (err) => {},
  });

  return (
    <div className="flex h-screen items-center justify-center bg-grey-900">
      <div className="mb-[30vh] flex flex-col items-center">
        <Loader />
        <div className="h-[25px]" />
        <p className=" text-[1.25rem] font-[700] text-white">
          Processing Incident
        </p>
        <div className="h-[16px]" />
        <p className=" mx-[35px] text-center text-[0.875rem] font-[400] text-[#B4B5B9]">
          We're loading a stream of the incident to your device. This shouldn't
          take more than a minute.
          <br />
          <br />⚠ NOTE: Emergency services (ie, 911) have not been notified.
        </p>
      </div>
    </div>
  );
};

export default IncidentPage;
