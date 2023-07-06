export const removeAddressTag: (r: string | undefined) => string = (raw) => {
    if (raw == undefined) return "";
    if (!raw.includes("+")) return raw;

    return raw.substring(raw.indexOf(" ") + 1);
}

export const extractMainAddress: (r: string) => string = (raw) => {
    return raw.substring(0, raw.indexOf(","));
}