import { NextPage } from "next";
import InfoPageBody from "safe/components/InfoPageBody";

const StoppedPage: NextPage = () => {
  return (
    <InfoPageBody
      header="The Incident has Ended"
      body="The user has stopped capturing the incident. As an emergency contact,
  you will receive an SMS message the user's final information shortly."
      image="stopped"
    />
  );
};

export default StoppedPage;
