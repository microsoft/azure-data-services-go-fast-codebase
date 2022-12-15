import React, { useState } from 'react';
import { animated, useSpring } from 'react-spring';
import FileDropState from './FileDropState';
import styles from './selectedFileOverlay.module.scss';

const SelectedFileOverlay = (props: {
    stateMachine: FileDropState;
    selectedFileFileName: string;
    uploadPercentage: number | null;
    onCancelUpload: () => void;
    onUploadFile: () => void;
}) => {
    const [animationComplete, setAnimationComplete] = useState<boolean>(false);
    const strokeDasharray: number = 3031;

    const showUploadProgressPercentage = () => !animationComplete && props.stateMachine !== FileDropState.Idle;

    const showUploadProgressBar = () => props.stateMachine !== FileDropState.Idle;

    const showUploadCompleted = () => animationComplete && props.stateMachine === FileDropState.UploadSucceeded;

    const showAwaitingServerResponse = () => animationComplete && props.stateMachine === FileDropState.AwaitingResponse;

    const showUploadFileButton = () => props.stateMachine === FileDropState.Idle || (animationComplete && props.stateMachine === FileDropState.UploadFailed);

    const uploadFileButtonText = () => (props.stateMachine === FileDropState.Idle ? 'Upload' : 'Try again');

    const uploadFileOnClick = () => {
        setAnimationComplete(false);
        props.onUploadFile();
    };

    //TODO: cannot to cancel an upload in progress at the moment.
    const showCancelUploadButton = () => showUploadFileButton();

    // strokeDashoffset of strokeDasharray = 0% complete; strokeDashoffset of 0 = 100% complete
    // arbitrarily calculated by playing around with svg
    const animationProps = useSpring({
        x: strokeDasharray - strokeDasharray * ((props.uploadPercentage ?? 0) / 100),
        onRest: () => {
            // the animation can stop and start - ensure this is only called once the file upload is also at 100%
            if (props.uploadPercentage === 100) return setAnimationComplete(true);
        },
    });

    // slice file name if it is over 20 characters long
    const normalisedFileName = props.selectedFileFileName.length <= 20 ? props.selectedFileFileName : props.selectedFileFileName.slice(0, 20) + '...';

    return (
        <div className={styles.selectedFileOverlay}>
            <img src="/csv-file.png" alt="csv file" className={styles.placeholderImage} />
            <p>{props.stateMachine === FileDropState.Uploading ? `uploading ${normalisedFileName}...` : normalisedFileName}</p>

            {showUploadProgressPercentage() && (
                <animated.div className={styles.percentText}>
                    {animationProps.x.to((x: number) => {
                        // interpolate strokeDashoffset to whole number percentage
                        const animatedPercentage = 100 - Math.floor((x / strokeDasharray) * 100);
                        return animatedPercentage + '%';
                    })}
                </animated.div>
            )}

            {showAwaitingServerResponse() && (
                <div>
                    <p>Please wait...</p>
                </div>
            )}

            {showUploadCompleted() && (
                <div className={styles.uploadSuccess}>
                    <img src="/check-circle.png" alt="check circle icon" />
                    <p>Upload complete.</p>
                </div>
            )}

            {showUploadProgressBar() && (
                <svg className={styles.uploadingProgress}>
                    <animated.rect
                        rx="40"
                        ry="40"
                        stroke="#9c2376"
                        fill="transparent"
                        className={styles.rect}
                        style={{
                            strokeDashoffset: animationProps.x,
                        }}
                    ></animated.rect>
                </svg>
            )}

            {showUploadFileButton() && (
                <button type="button" onClick={uploadFileOnClick} className={styles.heroButton}>
                    {uploadFileButtonText()}
                </button>
            )}

            {showCancelUploadButton() && (
                <button type="button" onClick={props.onCancelUpload} className={styles.cancelUploadButton}>
                    Choose a different file
                </button>
            )}
        </div>
    );
};

export default SelectedFileOverlay;
