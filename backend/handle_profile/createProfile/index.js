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
 * This function creates a profile and enters it in the profile table on dyn. 
 * Works on AWS
 * 
 */


export const handler = async(event) => {
    const body = event.body; //data 
    const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.http.method; //get, post, put, delete
    const {name, contact_info} = JSON.parse(body); 

    if (method === 'POST'){
        const params = {
            TableName: 'profile',
            Item: {
              'profile_id' : uuidv4(),
              'name' : name,
              'contact_info' : contact_info
            }
        }
        // TODO implement
        try {
            const dynamoResponse = await ddb.send(new PutCommand(params))
            const successfulResponse = {
                statusCode: 200,
                message: "Profile Created!"
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