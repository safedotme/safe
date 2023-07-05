import { DocumentData } from "firebase/firestore";
import sorter from 'sort-isostring';

export const sortByDateTimeIso: (data: DocumentData[]) => DocumentData[] = (data) => {
    data.sort((a, b) => sorter(b.datetime, a.datetime));

    return data
}

