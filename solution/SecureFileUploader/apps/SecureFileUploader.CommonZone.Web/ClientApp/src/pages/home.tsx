import styles from "../styles/index.module.scss";

const Home = () => {
  return (
    <div className={styles.pageContainer}>
      <head>
        <title>Uploader</title>
        <link rel="icon" href="/favicon.ico" />
        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href="/apple-touch-icon.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href="/favicon-32x32.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href="/favicon-16x16.png"
        />
        <link rel="manifest" href="/site.webmanifest" />
      </head>

      <main className={styles.contentContainer}>
        <img
          src="/logo.png"
          alt="practice assist logo"
          className={styles.logo}
        />
        <h1 className={styles.hero}>
          Welcome to the Primary Health Insights file uploader
        </h1>

        <div>
          <p>
            Please follow the instructions provided in your email to proceed.
          </p>
        </div>
      </main>
    </div>
  );
};

export default Home;
