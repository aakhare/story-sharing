
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, GetCommand } from '@aws-sdk/lib-dynamodb';


const ddb = new DynamoDBClient({
    region: 'us-west-1'
})

/****
 * 
 * This function returns all fields from the profile table after being given a profile_id. 
 * Works successfully on AWS console.
 */


export const handler = async(event) => {

    const {method} = event.requestContext.http;
    const queryParams = event.queryStringParameters
    
    if(method === "GET") {
      const params = {
        TableName: "profile",
        Key: {
          profile_id: queryParams.profile_id
        }
      }
      const dynamoRes = await ddb.send(new GetCommand(params))
      const profileItem = dynamoRes.Item
     
      return {
        statusCode: 200,
        body: {
          data: profileItem
        }
      }
    }
        
};