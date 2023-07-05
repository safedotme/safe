import { NextPage } from "next";
import { useRouter } from "next/router";
import { doc, getDoc, getFirestore } from "firebase/firestore";
import { getApp } from "firebase/app";
import incidentListen from "safe/services/firestore.service";

const Incident: NextPage = () => {
  // Initialize Router
  const router = useRouter();

  // Initialize Firestore
  const db = getFirestore(getApp());
  incidentListen({
    db: db,
    id: router.query.id as string,
    onFetch: () => {
      console.log("WORKED LETS GOO");
    },
    onError: () => {},
    onEnd: () => {},
  });

  return <h1>{router.query.id}</h1>;
};

export default Incident;
