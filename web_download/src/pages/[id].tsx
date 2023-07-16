import { NextPage } from "next";
import { useRouter } from "next/router";
import { getApp } from "firebase/app";
import { useEffect, useState } from "react";
import {
  FirebaseStorage,
  getDownloadURL,
  getStorage,
  ref,
} from "firebase/storage";
import { type } from "os";

const IncidentPage: NextPage = () => {
  // Initialize Router
  const router = useRouter();

  // Initialize Store
  const [url, setUrl] = useState<string | null>(null);
  const [isDark, setIsDark] = useState(false);
  let storage: FirebaseStorage | null = null;
  const fetchDownloadURL = async () => {
    if (storage == null) return null;

    const id = router.query.id;
    const idType = typeof id;
    if (idType != "string") return;

    const wRef = ref(storage, `${id as string}/raw/watermarked.mp4`);

    // Run every 10 seconds if url == null

    try {
      const res = await getDownloadURL(wRef);
      setUrl(res);
      window.location.replace(res);
    } catch (e) {}

    if (url != null) return;

    setTimeout(() => {
      void fetchDownloadURL();
    }, 10 * 1000);
  };

  // Initialize Firestore

  useEffect(() => {
    // Set theme
    const theme = window.matchMedia("(prefers-color-scheme: dark)");
    if (theme.matches) {
      setIsDark(true);
    }

    // Initialize Storage
    if (!router.isReady) return;
    const app = getApp();
    storage = getStorage(app);

    // Fetch video
    void fetchDownloadURL();
  }, [router.isReady]);

  return (
    <div className={`flex h-[100dvh] items-center justify-center `}>
      <div className="mb-[30dvh] flex flex-col items-center">
        <img
          src={isDark ? "loader_dark.svg" : "loader_light.svg"}
          className="animate-spin"
        />
        <div className="h-[25px]" />
        <p
          className={`text-[1.25rem] font-[700] ${
            isDark ? "text-white" : "text-[#373737]"
          }`}
        >
          Processing Incident
        </p>
        <div className="h-[16px]" />
        <p
          className={`mx-[35px] text-center text-[0.875rem] font-[400]  ${
            isDark ? "text-[#B4B5B9]" : "text-[#5E5E5E]"
          } max-w-[400px]`}
        >
          {`The incident data is being processed. Depending on the incident's duration, this could take between 5 - 45 minutes.`}
        </p>
      </div>
    </div>
  );
};

export default IncidentPage;
