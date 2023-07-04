import { type AppType } from "next/dist/shared/lib/utils";
import "safe/styles/globals.css";
import { getApp, initializeApp } from "firebase/app";
import { initializeAppCheck, ReCaptchaV3Provider } from "firebase/app-check";
import { env } from "../env.mjs";

// Firebase Setup

const firebaseConfig = {
  apiKey: env.NEXT_PUBLIC_API_KEY,
  authDomain: env.NEXT_PUBLIC_AUTH_DOMAIN,
  projectId: env.NEXT_PUBLIC_PROJECT_ID,
  storageBucket: env.NEXT_PUBLIC_STORAGE_BUCKET,
  messagingSenderId: env.NEXT_PUBLIC_MESSAGING_SENDER_ID,
  appId: env.NEXT_PUBLIC_APP_ID,
  measurementId: env.NEXT_PUBLIC_MEASUREMENT_ID,
};

initializeApp(firebaseConfig);

if (typeof window !== "undefined") {
  const appCheck = initializeAppCheck(getApp(), {
    provider: new ReCaptchaV3Provider(env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY),
    isTokenAutoRefreshEnabled: true,
  });
}

// Render App

const SafeWeb: AppType = ({ Component, pageProps }) => {
  return <Component {...pageProps} />;
};

export default SafeWeb;
