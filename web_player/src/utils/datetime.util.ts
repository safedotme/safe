const ensureDigitLength = (v: number) => v.toString().length == 1 ? `0${v}` : v

export const getFormattedTimeSinceDate: (d: Date | undefined) => string = (date) => {
    if (date == undefined) return "error"

    const current = new Date();
    const diff = Math.abs(current.getTime() - date.getTime());

    const hours = Math.trunc(diff/3600000)
    const minutes = Math.trunc(diff/60000)%60
    const seconds = (Math.trunc(diff/1000))%60

    return `${ensureDigitLength(hours)}:${ensureDigitLength(minutes)}:${ensureDigitLength(seconds)}`
}

export const formatTimeFromDate: (d: Date | undefined) => string = (date) => {
    if (date == undefined) return "error"

    const current = new Date();
    const diff = Math.abs(current.getTime() - date.getTime());

    const cDate = new Date(date.getTime() + diff);
    const raw = cDate.toLocaleTimeString();

    let colon = 0;
    let time = "";

    for (let i = 0; i < raw.length; i++){
        if (raw[i] === ":"){
            colon++
        }

        if (colon !== 2) {
            time += raw[i]
        }
    }

    time += raw.substring(raw.indexOf(" "))

    return time;
}