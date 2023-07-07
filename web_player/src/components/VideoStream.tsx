import { useEffect, useState } from "react";
import StreamLoader from "./StreamLoader";
import {
  AgoraVideoPlayer,
  IAgoraRTCRemoteUser,
  ICameraVideoTrack,
  IRemoteVideoTrack,
  createClient,
  createMicrophoneAndCameraTracks,
} from "agora-rtc-react";
import { Stream } from "safe/models/incident.model";
import { error } from "console";

interface VideoStreamProps {
  stream: Stream;
}

const VideoStream = (props: VideoStreamProps) => {
  const [isStreaming, setIsStreaming] = useState(false);
  const [streamer, setStreamer] = useState<IAgoraRTCRemoteUser | null>(null);
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

    const channelName = "test";
    const appId = "53afc3aa11c84a99bdd7444e816d39f3";
    const token =
      "007eJxTYOieMnGNavV9/ssLV2zdK7Jwog/PnkiZy5Oy5W0seLo+HdunwGBqnJiWbJyYaGiYbGGSaGmZlJJibmJikmphaJZibJlmzGiwPKUhkJGB6dodBkYoBPFZGEpSi0sYGABVgR9I";
    const uid = "0000";

    client
      .join(appId, channelName, token, null)
      .then((e) => {
        return;
      })
      .catch((e) => {
        return;
      });
  }, []);

  return (
    <div className="absolute left-0 top-0 ml-[16px] mt-[22px] h-[210px] w-[135px] rounded-[15px] bg-white">
      {isStreaming ? (
        <AgoraVideoPlayer
          videoTrack={streamer!.videoTrack!}
          key={streamer!.uid}
          style={{ height: "100%", width: "100%" }}
        />
      ) : (
        <StreamLoader />
      )}
    </div>
  );
};

export default VideoStream;
