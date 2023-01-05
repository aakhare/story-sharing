import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import { v4 as uuidv4 } from 'uuid';

const s3Client = new S3Client({
    region: 'us-west-1'
})


export const handler = async(event) => {
    // TODO implement
    console.log(event.body);
    const { profile_id, interview_type, interviewFile, digitalSignatureFile } = JSON.parse(event.body);
    const interviewFileKey = `${profile_id}_Interviews/${interview_type}/${uuidv4()}.${interviewFile.type}`
    const digitalSignatureFileKey = `${profile_id}_Interviews/${interview_type}/${uuidv4()}.-signature${digitalSignatureFile.type}`
    
    const interviewFileParams = 
        { 
            Bucket: "testbucket63419",
            Key: interviewFileKey
        };
    const digitalSignatureFileParams = 
        { 
            Bucket: "testbucket63419",
            Key: digitalSignatureFileKey
        };
        
    const putInterviewCommand = new PutObjectCommand(interviewFileParams);
    const putDigitalSignatureCommand = new PutObjectCommand(digitalSignatureFileParams);
    
    const interviewSignedURL = await getSignedUrl(s3Client, putInterviewCommand, {
        // extra possible fields: type, size of file (5GB max cutoff)
        expires: 50000 //ideal: 300
    } )
    
     const digitalSignatureSignedURL = await getSignedUrl(s3Client, putDigitalSignatureCommand, {
        expires: 50000 //ideal: 300
    } )
    
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            interviewSignedURL: interviewSignedURL,
            digitalSignatureSignedURL: digitalSignatureSignedURL,
            interviewFileKey: interviewFileKey,
            digitalSignatureFileKey: digitalSignatureFileKey
        }),
    };
    return response;
};
