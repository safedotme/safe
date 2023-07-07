import Head from "next/head";
import Link from "next/link";

export default function Index() {
  return (
    <>
      <Head>
        <title>Safe Web</title>
        <meta
          name="description"
          content="A violence encounter tool in your pocket."
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className=" flex h-[100dvh] bg-grey-900"></main>
    </>
  );
}
