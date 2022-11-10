enum FileDropState {
    Idle = "Idle",
    Uploading = "Uploading",
    AwaitingResponse = "AwaitingResponse",
    UploadFailed = "UploadFailed",
    UploadSucceeded = "UploadSucceeded",
}

export default FileDropState;
