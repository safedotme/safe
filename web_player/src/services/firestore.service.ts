import { DocumentData, Firestore, SnapshotOptions, getDoc } from "firebase/firestore";
import { doc, onSnapshot } from "firebase/firestore";
import { Incident } from "safe/models/incident.model";
import { sortByDateTimeIso } from "safe/utils/sorting.util";



interface IncidentListenerProps {
    db: Firestore, 
    id: string, 
    onFetch: (incident: Incident) => void, 
    onError: (e: any) => void,
}

const formatIncident: (data: DocumentData) => Incident | null = (data) => {

    try {
        const batteryLog: DocumentData[] = data.battery;
        const locationLog: DocumentData[] = data.location;

        const location = sortByDateTimeIso(locationLog)[0];
        const battery = sortByDateTimeIso(batteryLog)[0];

        if (battery == undefined || location == undefined){
            return null;
        }

        return {
            id: data.id,
            stream: {
                channelName: data.stream.channel_name,
                recordingId: data.stream.recording_id,
                resourceId: data.stream.resource_id,
                sid: data.stream.sid,
                userId: data.stream.user_id,
            },
            location: {
                lat: location.lat,
                long: location.long,
                speed: location.speed,
                address: location.address,
            },
            battery: battery.percentage,
        };
    } catch (err) {
        return null;
    }
}

const incidentListen = async (props: IncidentListenerProps) => {
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
            props.onError(error)
        }
    )

}

export default incidentListen;