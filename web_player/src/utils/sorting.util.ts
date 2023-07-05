import { DocumentData } from "firebase/firestore";
import sorter from 'sort-isostring';

export const sortByDateTimeIso: (data: DocumentData[]) => DocumentData[] = (data) => {
    data.sort((a, b) => sorter(b.datetime as string, a.datetime as string));

    return data
}

