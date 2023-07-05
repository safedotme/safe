export interface Incident {
    id: string,
    datetime: Date,
    stream: Stream,
    location: Location,
    battery: number,
}

export interface Stream {
    channelName: string,
    recordingId: string,
    resourceId: string,
    sid: string,
    userId: string,
}

export interface Location {
    address: string,
    lat: number,
    long: number,
    speed: number,
}
