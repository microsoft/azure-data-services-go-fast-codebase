import { ChangeEvent, useRef, useState } from 'react';
import { FileDrop as ReactFileDrop } from 'react-file-drop';
import FileDropState from './FileDropState';
import SelectedFileOverlay from './SelectedFileOverlay';
import styles from './fileDrop.module.scss';
import {convertUnitToBytes} from "../../lib/ByteConversion";

interface AllowedFileTypes{
    allowCsv: boolean;
    allowJson: boolean;
    allowZip: boolean;
}

interface Props {
    queryString: string;
    maxFileSize: number;
    minFileSize: number;
    fileSizeUnits: string;
    allowedFileTypes: AllowedFileTypes;
}

const FileDrop = (props: Props) => {
    const [stateMachine, setStateMachine] = useState<FileDropState>(FileDropState.Idle);
    const [error, setError] = useState<string | null>(null);
    const [selectedFile, setSelectedFile] = useState<File | null>(null);
    const [uploadPercentage, setUploadPercentage] = useState<number | null>(null);
    const [showDragAndDropOverlay, setShowDragAndDropOverlay] = useState<boolean>(false);

    // create ref for 'browse for file' functionality
    const inputFile = useRef(null as HTMLInputElement | null);

    const clearInputState = () => {
        setError(null);
        setSelectedFile(null);
        setUploadPercentage(null);
        setStateMachine(FileDropState.Idle);
    };

    const openFileBrowseDialog = () => {
        inputFile.current!.value = '';
        inputFile.current!.click();
    };

    const onFileChange = (event: ChangeEvent<HTMLInputElement>) => {
        event.stopPropagation();
        event.preventDefault();
        if (event.target.files?.length) {
            handleFileSelect(event.target.files);
        }
    };

    const fileDropEnabled = () => stateMachine === FileDropState.Idle || error;

    const onFrameDragEnter = () => {
        if (!fileDropEnabled()) return;
        setShowDragAndDropOverlay(true);
    };

    const onFrameDragLeave = () => {
        if (!fileDropEnabled()) return;
        setShowDragAndDropOverlay(false);
    };

    const onFrameDrop = () => {
        if (!fileDropEnabled()) return;
        setShowDragAndDropOverlay(false);
    };

    const handleFileSelect = (files: FileList) => {
        setError(null);
        setSelectedFile(null);
        setUploadPercentage(null);
        setStateMachine(FileDropState.Idle);

        // the initial requirements are that only a single file will be uploaded by a user
        if (files.length > 1) return setError('Please only select a single file.');

        // Check which file types are allowed in AllowedFileTypes
        // Convert the file type to real world file extension
        // E.G .csv = text/csv and .json = application/json
        // Check if the file type is allowed using a switch statement
        // If the file type is not allowed, return an error
        const fileType = files[0].type;
        let fileExtension = '';
        switch (fileType) {
            case 'text/csv':
                fileExtension = '.csv';
                if (!props.allowedFileTypes.allowCsv) return setError('CSV files are not allowed.');
                break;
            case 'application/json':
                fileExtension = '.json';
                if (!props.allowedFileTypes.allowJson) return setError('JSON files are not allowed.');
                break;
            case 'application/zip':
                fileExtension = '.zip';
                if (!props.allowedFileTypes.allowZip) return setError('ZIP files are not allowed.');
                break;
            default:
                return setError('File type not allowed.');
        }

        if (props.minFileSize != 0){
            if (convertUnitToBytes(files[0].size, props.fileSizeUnits) < props.minFileSize) {
                return setError(`File size must be greater than ${props.minFileSize} ${props.fileSizeUnits}.`);
            }
        }

        if (props.maxFileSize != 0){
            if (convertUnitToBytes(files[0].size, props.fileSizeUnits) > props.maxFileSize) {
                return setError(`File size must be less than ${props.maxFileSize} ${props.fileSizeUnits}.`);
            }
        }

        setSelectedFile(files[0]);
    };

    const uploadFile = async (file: File) => {
        try {
            setError(null);
            // setSelectedFile(null);
            setUploadPercentage(null);
            setStateMachine(FileDropState.Uploading);

            const payload = new FormData();
            payload.append('file', file);
            payload.append("queryString", props.queryString)
            const xhr = new XMLHttpRequest();

            xhr.open('POST', `/api/upload`);

            xhr.upload.onerror = function () {
                console.error(xhr);
                return setError(`Failed to upload.`);
            };

            xhr.upload.onprogress = (event) => {
                const percentage = Math.floor((event.loaded / event.total) * 100);
                setUploadPercentage(percentage);
                if (percentage === 100) {
                    setStateMachine(FileDropState.AwaitingResponse);
                }
            };

            xhr.onreadystatechange = function () {
                if (xhr.readyState !== XMLHttpRequest.DONE) return;

                if (this.status >= 400 && this.status <= 499) {
                    setStateMachine(FileDropState.UploadFailed);
                    console.error(xhr);
                    setError(!!xhr.responseText ? xhr.responseText : 'Failed to upload. Please try again.');
                    return;
                }

                if (this.status >= 500 && this.status <= 599) {
                    setStateMachine(FileDropState.UploadFailed);
                    console.error(xhr);
                    setError('Failed to upload. Please try again.');
                    return;
                }

                if (this.status === 204) {
                    setStateMachine(FileDropState.UploadSucceeded);
                    return;
                }

                throw new Error('Unexpected state');
            };

            xhr.send(payload);
        } catch (error: any) {
            console.error(error);
            setError(error.message);
        }
    };

    return (
        <ReactFileDrop
            targetClassName={`${styles.uploadTarget} ${selectedFile && styles.fileSelected}`}
            draggingOverTargetClassName={fileDropEnabled() ? styles.uploadTargetActive : ''}
            onFrameDragEnter={onFrameDragEnter}
            onFrameDragLeave={onFrameDragLeave}
            onFrameDrop={onFrameDrop}
            onDrop={(files) => {
                if (!fileDropEnabled()) return;
                if (files && files.length > 0) handleFileSelect(files);
            }}
        >
            {/* this input is invisible - we trigger it's 'browse for file' functionality with the selectFile button */}
            <input type="file" id="file" ref={inputFile} accept=".json" onChange={onFileChange} style={{ display: 'none' }} />
            <img src="/json-file.png" alt="json file" className={styles.placeholderImage} />
            <div className={styles.instructionsContainer}>
                <p className={styles.dragAndDropInstruction}>Drag and drop a file to upload</p>
                <p className={styles.instructionsDivider}>or</p>
            </div>
            <button type="button" onClick={openFileBrowseDialog} className={styles.heroButton}>
                Select a file
            </button>

            {selectedFile && (
                <SelectedFileOverlay
                    stateMachine={stateMachine}
                    selectedFileFileName={selectedFile.name}
                    uploadPercentage={uploadPercentage}
                    onCancelUpload={clearInputState}
                    onUploadFile={() => uploadFile(selectedFile)}
                />
            )}

            <div className={styles.error}>
                <p>{error}</p>
            </div>

            {showDragAndDropOverlay && (
                <div onClick={() => setShowDragAndDropOverlay(false)} className={styles.dropFilePrompt}>
                    <p>Drop your file here</p>
                </div>
            )}
        </ReactFileDrop>
    );
};

export default FileDrop;
