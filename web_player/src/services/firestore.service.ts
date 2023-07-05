import { Firestore } from "firebase/firestore";
import { doc, onSnapshot } from "firebase/firestore";
import { Incident } from "safe/models/incident.model";



interface IncidentListenerProps {
    db: Firestore, 
    id:string, 
    onFetch: (incident: Incident) => void, 
    onError: () => void,
    onEnd: () => void,
}


const incidentListen = (props: IncidentListenerProps) => {
    const unsub = onSnapshot(doc(props.db, "incidents", props.id),
        (doc) => {
            const data = doc.data();

            if (data == undefined){
                props.onError();
                return;
            }

            props.onFetch({
                id: data.id,
                stream: {},
                location: {},
                battery: 1,
            });
        },
        (error) => {
            props.onError();
        }
    );
}

export default incidentListen;