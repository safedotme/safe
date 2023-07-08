import { useEffect, useState } from "react";
import {
  AgoraVideoPlayer,
  IAgoraRTCRemoteUser,
  createClient,
} from "agora-rtc-react";
import { Stream } from "safe/models/incident.model";
import {
  TokenRole,
  TokenType,
  generateRTCToken,
  generateRandomUid,
} from "safe/services/media.service";
import { env } from "safe/env.mjs";

interface VideoStreamProps {
  stream: Stream;
  isDark: boolean;
}

const VideoStream = (props: VideoStreamProps) => {
  const [isStreaming, setIsStreaming] = useState(false);
  const [streamer, setStreamer] = useState<IAgoraRTCRemoteUser | null>(null);
  const [isLarge, setIsLarge] = useState(false);
  const client = createClient({ mode: "rtc", codec: "h264" })();

  useEffect(() => {
    client.on("user-published", (user, mediaType) => {
      client
        .subscribe(user, mediaType)
        .then(() => {
          if (mediaType === "video") {
            setStreamer(user);
            setIsStreaming(true);
          }

          if (mediaType === "audio") {
            user.audioTrack?.play();
          }
        })
        .catch((e) => {
          return;
        });
    });

    const uid = generateRandomUid();

    generateRTCToken({
      channelName: props.stream.channelName,
      type: TokenType.userAccount,
      role: TokenRole.publisher,
      uid: uid,
    })
      .then((token) => {
        if (token == null) return;

        // Join Call
        client
          .join(
            env.NEXT_PUBLIC_AGORA_APP_ID,
            props.stream.channelName,
            token,
            uid
          )
          .then((e) => {
            return;
          })
          .catch((e) => {
            return;
          });
      })
      .catch((e) => {
        return;
      });
  }, []);

  return (
    <div
      className={`absolute left-0 top-0  mt-[22px] ${
        isLarge
          ? "ml-[0px] h-[155vw] w-[100vw]"
          : "ml-[16px] h-[210px] w-[135px]"
      }  overflow-hidden rounded-[15px] border-[3px] border-white/[0.2] ${
        props.isDark
          ? "bg-grey-400/[0.75] backdrop-blur-[20px]"
          : " bg-[#ACACAC]/[0.6] backdrop-blur-[10px]"
      }  transition-all`}
    >
      {isStreaming ? (
        <AgoraVideoPlayer
          videoTrack={streamer!.videoTrack!}
          key={streamer!.uid}
          style={{
            height: "100%",
            width: "100%",
          }}
          onClick={() => {
            setIsLarge(!isLarge);
          }}
        />
      ) : (
        <div className="flex h-full">
          <img
            src="loader_small.png"
            className="m-auto h-[35px] animate-spin"
          />
        </div>
      )}
    </div>
  );
};

export default VideoStream;
