import { env } from "safe/env.mjs";

export const fetchTimezoneFromCoordinates: (lat: number, lng: number, date: Date) => Promise<string> = async (lat, lng, date) => {
    const base = "https://maps.googleapis.com/maps/api/timezone/json";
    const location = `${lat},${lng}`;
    const key = env.NEXT_PUBLIC_TIMEZONE_KEY;
    const timestamp = Math.trunc(date.getTime() / 1000);

    try {
        const res = await fetch(`${base}?location=${location}&timestamp=${timestamp}&key=${key}`, {
            method: "GET",
            headers: {
                Accept: "application/json"
            }
        })

        const raw = await res.json();

        if (raw.status == "OK"){
            return raw.timeZoneName.replace(/[^A-Z]/g, '');
        }

        throw new Error(raw.status)

    } catch (e) {
        throw new Error(e as string)
    }
} 