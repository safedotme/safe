const getBatteryStatus = (val: number) => {
    switch (true) {
        case val < 0.1:
            return "CRITICAL";
        case val < 0.2:
            return "LOW";
        case val < 0.8:
            return "NORMAL";
        default:
            return "HIGH";
    }
}

export const formatBattery = (battery: number) => {
    const percentage = (battery * 100).toFixed(0)

    return `${percentage}% (${getBatteryStatus(battery)})`;
}

