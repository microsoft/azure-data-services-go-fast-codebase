// import Head from "next/head";
import {useSearchParams} from 'react-router-dom'
// import { objToQS } from "../lib/shared/util";
import FileDrop from "../components/fileDrop/FileDrop";
import styles from "../styles/upload.module.scss";
import {useQuery} from "@tanstack/react-query";

export default function Upload() {
    const [searchParams, setSearchParams] = useSearchParams();
    const queryString = searchParams.get("queryString")!

    const {isLoading, error, data} = useQuery(['upload'], () =>
        fetch(`/api/upload?${queryString}`, {
            method: 'GET'
        })
            .then(response => response.json()))

    return (
        <div className={styles.pageContainer}>
            <main className={styles.contentContainer}>

                {!isLoading &&
                    <img
                        src={
                            data.phnLogo === '' ? '/logo.png' : `data:image/png;base64,${data.phnLogo}`
                        }
                        alt="practice assist logo"
                        className={styles.logo}
                    />
                }
                {!isLoading &&
                    <h1 className={styles.title}>{data.programName}</h1>
                }
                {!isLoading &&
                    <p>
                        Thank you in advance for uploading your file. Once you have uploaded
                        the file please expect to receive an email to confirm the upload was
                        successful.
                    </p>
                }
                {!isLoading &&
                    <FileDrop queryString={queryString} maxFileSize={data.maxFileSize} minFileSize={data.minFileSize} fileSizeUnits={data.fileSizeUnits} allowedFileTypes={data.allowedFileTypes}/>
                }
            </main>
        </div>
    );
}
