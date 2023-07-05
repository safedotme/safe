import { Firestore } from "firebase/firestore";
import { doc, onSnapshot } from "firebase/firestore";

interface Incident {
    id: string
}

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
            });
        },
        (error) => {
            props.onError();
        }
    );
}

export default incidentListen;