import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcryptjs';
import 'dayjs';

const ddb = new DynamoDBClient({
    region: 'us-west-1'
})

/****
 * 
 * This function creates an interview and enters it in the user table on dyn. 
 * Works on AWS 
 * 
 */


export const handler = async(event) => {
    const body = event.body; //data 
    const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.http.method; //get, post, put, delete
    const {profile_id, format, title, content, description, is_anonymous, digital_signature} = JSON.parse(body); 
    let date = dayjs(new Date());
    let status = "pending";
    let flagged = false;
    

    if (method === 'POST'){
        const params = {
            TableName: 'interview',
            Item: {
              'interview_id' : uuidv4(),
              'profile_id' : profile_id,
              'digital_signature': digital_signature,
              'title' : title,
              'format' : format,
              'content' : content,
              'description' : description,
              'date' : date, 
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
            body: successfulResponse
            }
             
            return response;
        } catch (e){
            console.log(e.message);
            const response = {
                statusCode: 500,
                body: "Error!",
            };
            return response;
            
        }
    }
        
};