import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcryptjs';

const ddb = new DynamoDBClient({
    region: 'us-west-1'
})


export const handler = async(event) => {
    console.log(event);
    //const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.httpMethod; //get, post, put, delete
    const {email, password, first_name, last_name} = JSON.parse(event.body); 

    if (method === 'POST'){
        const hash_password = await bcrypt.hash(password, 12)
        const user_id = uuidv4();
        const params = {
            TableName: 'user',
            Item: {
              'user_id' : user_id,
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
                message: "Registration successful!",
                userDetails:  {
                    'user_id' : user_id,
                    'first_name' : first_name,
                    'last_name' : last_name,
                }
             }
            const response = {
                statusCode: 200,
                body: JSON.stringify(successfulResponse),
                headers: {
                    //"Set-Cookie": `user_id=${user_id}`
                }
            }
            return response;
        } catch (e){
            console.log(e.message);
            const response = {
                statusCode: 500,
                body: JSON.stringify(e.message),
                
            };
            return response;
            
        }
    }
        
};