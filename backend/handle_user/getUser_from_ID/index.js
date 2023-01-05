
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, GetCommand } from '@aws-sdk/lib-dynamodb';


const ddb = new DynamoDBClient({
    region: 'us-west-1'
})

/****
 * 
 * This function returns all fields from the user table (except password) after being given a user_id. 
 * Works successfully on AWS console.
 * 
 */


export const handler = async(event, context, callback) => {

    const {method} = event.requestContext.http;
    const queryParams = event.queryStringParameters
    
    if(method === "GET") {
      const params = {
        TableName: "user",
        Key: {
          user_id: queryParams.user_id
        }
      }
      const dynamoRes = await ddb.send(new GetCommand(params))
      const userItem = dynamoRes.Item
      delete userItem.hash_password;
      return {
        statusCode: 200,
        body: {
          data: userItem
        }
      }
    }
        
};