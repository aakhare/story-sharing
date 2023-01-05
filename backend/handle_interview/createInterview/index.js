import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcryptjs';
import dayjs from 'dayjs';

const ddb = new DynamoDBClient({
    region: 'us-west-1'
})

/****
 * 
 * This function creates an interview and enters it in the user table on dyn. 
 * 
 */


export const handler = async(event) => {
    //const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.httpMethod; //get, post, put, delete

    const {profile_id, format, title, content, description, is_anonymous, digital_signature} = JSON.parse(event.body); 
    let date = dayjs(new Date());
    let status = "pending";
    let flagged = false;
  

    if (method === "POST"){
        const params = {
            TableName: 'interview',
            Item: {
              'interview_id' : uuidv4(),
              'profile_id' : profile_id,
              'digital_signature': digital_signature, //from s3
              'title' : title,
              'format' : format,
              'content' : content, //from s3 
              'description' : description,
              'date' : date.toISOString(), 
              'status': status,
              'is_anonymous': is_anonymous,
              'flagged': flagged
            }
        }
        // TODO implement
        try {
            const dynamoResponse = await ddb.send(new PutCommand(params))
            const successfulResponse = {
                statusCode: 200,
                message: "Interview Created!"
                }
            const response = {
            statusCode: 200,
            body: JSON.stringify(successfulResponse)
            }
             
            return response;
        } catch (e){
            console.log(e.message);
            const response = {
                statusCode: 500,
                body: JSON.stringify(e.message)
            };
            return response;
            
        }
    }
        
};