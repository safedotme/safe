import { createEnv } from "@t3-oss/env-nextjs";
import { z } from "zod";

export const env = createEnv({
  server: {
    NODE_ENV: z.enum(["development", "test", "production"]),
  },

  client: {
    NEXT_PUBLIC_API_KEY: z.string().min(1),
    NEXT_PUBLIC_AUTH_DOMAIN: z.string().min(1),
    NEXT_PUBLIC_PROJECT_ID: z.string().min(1),
    NEXT_PUBLIC_STORAGE_BUCKET: z.string().min(1),
    NEXT_PUBLIC_MESSAGING_SENDER_ID: z.string().min(1),
    NEXT_PUBLIC_APP_ID: z.string().min(1),
    NEXT_PUBLIC_MEASUREMENT_ID: z.string().min(1),
    NEXT_PUBLIC_RECAPTCHA_SITE_KEY: z.string().min(1),
    NEXT_PUBLIC_MAPS_KEY: z.string().min(1),
    NEXT_PUBLIC_TIMEZONE_KEY: z.string().min(1),
    NEXT_PUBLIC_AGORA_APP_ID: z.string().min(1),
    NEXT_PUBLIC_AGORA_CERT: z.string().min(1),
    NEXT_PUBLIC_AGORA_CUSTOMER_KEY: z.string().min(1),
    NEXT_PUBLIC_AGORA_CUSTOMER_SECRET: z.string().min(1),
    NEXT_PUBLIC_MEDIA_ENDPOINT: z.string().min(1),
    NEXT_PUBLIC_MEDIA_KEY: z.string().min(1),
    NEXT_PUBLIC_MEDIA_SECRET: z.string().min(1),
  },

  runtimeEnv: {
    NODE_ENV: process.env.NODE_ENV,
    NEXT_PUBLIC_API_KEY: process.env.NEXT_PUBLIC_API_KEY,
    NEXT_PUBLIC_AUTH_DOMAIN: process.env.NEXT_PUBLIC_AUTH_DOMAIN,
    NEXT_PUBLIC_PROJECT_ID: process.env.NEXT_PUBLIC_PROJECT_ID,
    NEXT_PUBLIC_STORAGE_BUCKET: process.env.NEXT_PUBLIC_STORAGE_BUCKET,
    NEXT_PUBLIC_MESSAGING_SENDER_ID: process.env.NEXT_PUBLIC_MESSAGING_SENDER_ID,
    NEXT_PUBLIC_APP_ID: process.env.NEXT_PUBLIC_APP_ID,
    NEXT_PUBLIC_MEASUREMENT_ID: process.env.NEXT_PUBLIC_MEASUREMENT_ID,
    NEXT_PUBLIC_RECAPTCHA_SITE_KEY: process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY,
    NEXT_PUBLIC_MAPS_KEY: process.env.NEXT_PUBLIC_MAPS_KEY,
    NEXT_PUBLIC_TIMEZONE_KEY: process.env.NEXT_PUBLIC_TIMEZONE_KEY,
    NEXT_PUBLIC_AGORA_APP_ID: process.env.NEXT_PUBLIC_AGORA_APP_ID,
    NEXT_PUBLIC_AGORA_CERT: process.env.NEXT_PUBLIC_AGORA_CERT,
    NEXT_PUBLIC_AGORA_CUSTOMER_KEY: process.env.NEXT_PUBLIC_AGORA_CUSTOMER_KEY,
    NEXT_PUBLIC_AGORA_CUSTOMER_SECRET: process.env.NEXT_PUBLIC_AGORA_CUSTOMER_SECRET,
    NEXT_PUBLIC_MEDIA_ENDPOINT: process.env.NEXT_PUBLIC_MEDIA_ENDPOINT,
    NEXT_PUBLIC_MEDIA_KEY: process.env.NEXT_PUBLIC_MEDIA_KEY,
    NEXT_PUBLIC_MEDIA_SECRET: process.env.NEXT_PUBLIC_MEDIA_SECRET,
  },

  skipValidation: !!process.env.SKIP_ENV_VALIDATION,
});
