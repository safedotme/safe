import { Firestore } from "firebase/firestore";
import { doc, onSnapshot } from "firebase/firestore";
import { Incident } from "safe/models/incident.model";



interface IncidentListenerProps {
    db: Firestore, 
    id: string, 
    onFetch: (incident: Incident) => void, 
    onError: (e: any) => void,
}


const incidentListen = (props: IncidentListenerProps) => {
    try {
        const unsub = onSnapshot(doc(props.db, "incidents", props.id),

        // Listen to changes
        (doc) => {
            if (!doc.exists) {
                return;
            }


            const data = doc.data();

            if (data == undefined){
                props.onError("Data is undefined");
                return;
            }

            try {
                const formattedData = {
                    id: data.id,
                    stream: {
                        channelName: data.stream.channel_name,
                        recordingId: data.stream.recording_id,
                        resourceId: data.stream.resource_id,
                        sid: data.stream.sid,
                        userId: data.stream.user_id,
                    },
                    location: {
                        lat: 0,
                        long: 0,
                        speed: 0,
                        address: "",
                    },
                    battery: 1,
                }

                props.onFetch(formattedData);

            // Catch formatting errors
            } catch (e) {
                props.onError(e)
            }
        },

        // Catch Firestore errors
        (error) => {
            props.onError(error);
        }
    );

    // Catch unexpected errors
    } catch (e) {
        props.onError(e)
    }
}

export default incidentListen;