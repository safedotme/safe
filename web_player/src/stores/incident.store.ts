import { Incident } from "safe/models/incident.model";
import { create } from "zustand";

interface IncidentStore {
    id: string,
    incident: Incident | null,
    fetched: boolean,

    setId: (v: string) => void
    setFetched: (v: boolean) => void
    setIncident: (v: Incident) => void
}

const useIncidentStore = create<IncidentStore>((set) => ({
    id: "",
    incident: null,
    fetched: false,
    setId: (v: string) => set((state) => ({
        id: v
    })),
    setFetched: (v: boolean) => set((state) => ({
        fetched: v
    })),
    setIncident: (v: Incident) => set((state) => ({
        incident: v
    }))
}))

export default useIncidentStore