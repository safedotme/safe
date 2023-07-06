import { DocumentData, Firestore, SnapshotOptions, getDoc } from "firebase/firestore";
import { doc, onSnapshot } from "firebase/firestore";
import { Incident } from "safe/models/incident.model";
import { sortByDateTimeIso } from "safe/utils/sorting.util";



interface IncidentListenerProps {
    db: Firestore, 
    id: string, 
    onFetch: (incident: Incident) => void, 
    onError: (e: string) => void,
}

const formatIncident: (data: DocumentData) => Incident | null = (data) => {

    try {
        const batteryLog = data.battery as DocumentData[];
        const locationLog = data.location as DocumentData[];
        const stream = data.stream as DocumentData

        const location = sortByDateTimeIso(locationLog)[0];
        const battery = sortByDateTimeIso(batteryLog)[0];

        if (battery == undefined || location == undefined){
            return null;
        }

        const date = new Date(data.datetime as string);
        

        return {
            id: data.id as string,
            datetime: date,
            stream: {
                channelName: stream.channel_name as string,
                recordingId: stream.recording_id as string,
                resourceId: stream.resource_id as string,
                sid: stream.sid as string,
                userId: stream.user_id as string,
            },
            location: {
                lat: location.lat as number,
                long: location.long as number,
                speed: location.speed as number,
                address: location.address as string,
            },
            battery: battery.percentage as number,
        };
    } catch (err) {
        return null;
    }
}

const incidentListen = (props: IncidentListenerProps) => {
    const docRef = doc(props.db, "incidents", props.id)

    onSnapshot(docRef,
        // Listen to Changes
        (doc) => {
            if (!doc.exists) {
                props.onError("Document does not exist")
                return;
            }

            const data = doc.data()

            if (data == undefined) {
                props.onError("Data is undefined")
                return;
            }

            const incident = formatIncident(data);

            if (incident == null) {
                props.onError("Failed to format incident")
                return;
            }

            props.onFetch(incident);
        },
        // Listen to Errors
        (error) => {
            props.onError(error.message)
        }
    )

}

export default incidentListen;