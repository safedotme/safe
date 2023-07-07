import { NextPage } from "next";
import InfoPageBody from "safe/components/InfoPageBody";

const ErrorPage: NextPage = () => {
  return (
    <InfoPageBody
      header="Error Loading Incident"
      body="This incident has failed to load. This is most likely due to ID next
      to the URL. Check the ID (live.joinsafe.me/{id}) is valid."
      image="error"
    />
  );
};

export default ErrorPage;
