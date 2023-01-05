import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, GetCommand } from '@aws-sdk/lib-dynamodb';
import bcrypt from 'bcryptjs';

const ddb = new DynamoDBClient({
    region: 'us-west-1'
    /*
    credentials : {
        accessKey_Id :
        secretKey_Id :
    }
    */
})


export const handler = async(event) => {
    const queryParams = event.queryStringParamaters; //data from frontend
    const method = event.requestContext.http.method; //get, post, put, delete
   // const {user_id} = queryParams
    const {email, password} = event.body;
    
    if (method === 'POST'){
      
        const params = {
            TableName: 'user',
            Key: {
                user_id: queryParams.user_id
            }
        }
        // TODO implement
        try {
            const dynamoResponse = await ddb.send(new GetCommand(params))
            const userItem = dynamoResponse.Item
            console.log(userItem);
            const hash_password = userItem.hash_password;
            bcrypt.compare(password, hash_password, function(result) {
                if (result) {
                    const response = {
                            statusCode: 200,
                            body: dynamoResponse,
                        };
                    return response;
                }
            });
           
            
        } catch (e){
            console.log(e.message);
            const response = {
                statusCode: 500,
                body: e.message,
            };
            return response;
            
        }
    }
        
};