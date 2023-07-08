import { env } from "safe/env.mjs";

export enum TokenRole { 
  publisher = "publisher",
  subscriber = "subscriber"
 }

export enum TokenType {
  uid = "uid",
  userAccount = "userAccount"
}

interface RTCTokenProps {
  channelName: string,
  role: TokenRole,
  type: TokenType,
  uid: number,
}

interface MediaRTCTokenProps {
uid: string,
appId: string,
appCertificate: string,
role: string,
tokenType: string,
channelName: string
}

interface MediaRTCTokenResponse {
  token: string
  status: number
}

export const generateRandomUid: () => number = () => {
  let uid = ""

  for (let i = 0; i < 8; i++){
    const random = Math.floor(Math.random() * 10);

    uid += random
  }

  return Number(uid);
}

export const generateRTCToken = async (props: RTCTokenProps) => {
    const endpoint = `${env.NEXT_PUBLIC_MEDIA_ENDPOINT}/rtc?key=${env.NEXT_PUBLIC_MEDIA_SECRET}`

    const body: MediaRTCTokenProps = {
      uid: props.uid.toString(),
      appId: env.NEXT_PUBLIC_AGORA_APP_ID,
      appCertificate: env.NEXT_PUBLIC_AGORA_CERT,
      role: props.role,
      tokenType: props.type,
      channelName: props.channelName,
    };

    let response: Response | null = null;

    try {
      response = await fetch(endpoint, {
        method: "POST",
        body: JSON.stringify(body),
      })
    } catch (e) {
      return null
    }

    if (response == null) return null;

    const result = await response.json() as MediaRTCTokenResponse;

    return result.token;
}