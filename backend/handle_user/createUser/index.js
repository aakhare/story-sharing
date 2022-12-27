import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcryptjs';

const ddb = new DynamoDBClient({
    region: 'us-west-1'
})

/****
 * 
 * This function creates user and enters it in the user table on dyn(except password) after being given a user_id. 
 * Works successfully on AWS console.
 */


export const handler = async(event) => {
    const body = event.body; //data 
    const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.http.method; //get, post, put, delete
    const {email, password, first_name, last_name} = JSON.parse(body); 

    if (method === 'POST'){
        const hash_password = await bcrypt.hash(password, 12)
        const params = {
            TableName: 'user',
            Item: {
              'user_id' : uuidv4(),
              'first_name' : first_name,
              'last_name' : last_name,
              'email' : email,
              'hash_password' : hash_password,
            }
        }
        // TODO implement
        try {
            const dynamoResponse = await ddb.send(new PutCommand(params))
            const successfulResponse = {
                statusCode: 200,
                message: "Registration successful!"
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
            body: "Registration unsuccessful! Please check if you have already created an account with us!",
            };
            return response;
            
        }
    }
        
};