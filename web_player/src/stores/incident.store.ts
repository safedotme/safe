import { Incident } from "safe/models/incident.model";
import { create } from "zustand";

interface IncidentStore {
    incident: Incident | null,
    fetched: boolean,
    timezone: string,
    

    setTimezone: (v: string) => void
    setFetched: (v: boolean) => void
    setIncident: (v: Incident) => void
}

const useIncidentStore = create<IncidentStore>((set) => ({
    incident: null,
    fetched: false,
    timezone: "",

    setTimezone: (v: string) => set(() => ({
        timezone: v
    })),
    setFetched: (v: boolean) => set(() => ({
        fetched: v
    })),
    setIncident: (v: Incident) => set(() => ({
        incident: v
    }))
}))

export default useIncidentStore