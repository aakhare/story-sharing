# Database Schema 

Below is the database schema for the entire project. Four key tables will be used: **user**, **profile**, **interview**, and **stories**, across all applications made. The user table will consist of data pertaining to the admin team for them to create an account and log in. The profile table will consist of personal information pertaining to the participant being interviewed. The interview table will consist of all relevant data about the interview, as it is taken. And finally, the stories table will contain all data pertinent to the story that will ultimately feature the stories application. The ids in every table will help providing an unique identifier for every new item

## user table

| Field | Type   | Key  
| :---     | :---    | :--- |
| user_id | String | Partition Key |
| email   | String | 
| password | String |
| first_name | String | 
| last_name | String |

## profile table 

| Field | Type   | Key  
| :---     | :---    | :--- |
| profile_id | String | Partition Key |
| contact_info   | String | 
| name | String |

## interview table 

| Field | Type   | Key  
| :---     | :---    | :--- |
| interview_id | String | Partition Key |
| profile_id   | String | Global Secondary Index |
| digital_signature | String |
| interview_format | String | 
| interview_title  | String |
| interview_description | String |
| interview_content | String |
| interview_date    | String |
| interview_status  | String |
| flagged | Boolean | 
| is_anonymous | Boolean |

## story table 

| Field | Type   | Key  
| :---     | :---    | :--- |
| story_id | String | Partition Key |
| profile_id   | String | Global Secondary Index 1 |
| interview_id | String | Global Secondary Index 2 |
| story_caption | String | 
| story_content  | String |
| story_status | String |
| story_title | String |
| tags    | List |




# Table Examples

### sample user table

For security purposes, the user_id will be auto-generated using the `UUID package`. The plain-text password recieved from the front-end will be encrypted using the `Bcrypt package` before being entered into the database.    

| user_id  | email   | password  | first_name | last_name |
| :---     | :---    | :---      | :---       | :---      |
| "3b35b4f1-2b4a-4084-a1a7-16b8386ff9e0" | "first.last@gmail.com" | "$2y$14$.CQfDzsn3N9YTwbhc96Js.XLHpzLL1npmU5hLvrjjGUHBKH21gYPW" | "first" | "last" |


### sample profile table 

The contact information of an interviewee/participant will be in the form of a string, giving a flexible option for users to input an address, a phone number, email address, or any other identifying information. As with the `user_id`, the `profile_id` will be auto-generated using the `UUID package`

| profile_id  | contact_info   | name |
| :---     | :---    | :---     
| "d701af18-edda-4fc1-aa09-7b438f73ba27" | "(123)-245-678" | "participant 1" |


### sample interview table 

The `interview_id` will be auto-generated, and an existing `profile_id` will be matched to the table. The `status` and `flagged` attributes will be given a default value of `pending` and `false`, respectively, until both are changed through the content manager web application. Other attributes include metadata about the interview and the content of the interview itself. The `format` attribute must only either be `video`, `audio`, or `text`. The `status` attribute must only either be `pending`, `approved`, `denied`, or `laid aside`. 

| interview_id  | profile_id   | interview_format  | interview_title | interview_content | interview_description | interview_date | digital_signature | is_anonymous | interview_status | flagged
| :---     | :---    | :---      | :---      | :---      | :---    | :---   | :---   | :---  | :---  | :---
| "8922c504-68d4-4c13-88fa-c05f271803b4" | "e9a94732-176e-4b4b-bf03-32461ada23bb" | "video" | "Health update" | "url.mp4" | "Participant discusses health issues ... " | "December 21, 2022" | "url.mp4" | true | "pending" | false | 


### sample stories table 

The `story_id` will be auto-generated, and an existing `interview_id` and `profile_id` will be matched to the table. The `story_status` can either be `published` or `draft`. 

| story_id  | interview_id   | profile_id  | story_title | story_caption | story_content | tags | story_status 
| :---     | :---    | :---      | :---      | :---      | :---    | :---   | :---   
| "93db2af2-ce28-424a-b12c-822be27e671d" | "8922c504-68d4-4c13-88fa-c05f271803b4" | "e9a94732-176e-4b4b-bf03-32461ada23bb" | "Growing Health Concerns in Uganda" | "Learn about health issues with pregnancy" | "In an interview with... " | ["health", "education"] | "published" |


# Endpoints 

## Interview 

1. #### `createUser`
    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/users
    
    object sent by frontend: 
    
    ``` JSON 
    {
      "first_name" : String,
      "last_name" : String,
      "email": String,
      "password": String
    }
    ```
     
    object returned by backend: 
    
    ``` JSON 
    {
      "message" : "Registration successful!"
      "statusCode" : 200,
    } 
    ```
    backend will also return a cookie with an access token, which frontend should save
    
2. #### `getUser`
    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/login
    
    object sent by frontend (use `POST` request): 
    
    ``` JSON 
    {
      "email": String,
      "password": String
    }
    ```
    frontend should use the saved cookie and pass it into the header options like this: 
    
    `"Cookie": "AccessToken= "` where the access token is the value from the cookie
    
    object returned by backend: 
    
    ``` JSON 
    {
      "message" : "Login successful!",
      "statusCode" : 200,
      "token": String,
    } 
    ```
 3. #### `updateUserPassword`
    endpoint url: https://grhys5d6mv2zr2brcm4g7vrmhu0uegxn.lambda-url.us-west-1.on.aws/
    
    object sent by frontend
    
    ``` JSON 
    {
      "email": String,
      "password": String
    }
    ```
    
    object returned by backend: 
    
    ``` JSON 
    {
      "statusCode" : 200,
      "message" : "Update successful!",
      "data" : {
          "user_id": String
      }
      
    } 

    
4. #### `createProfile`
    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/profiles

    object sent by frontend: 
    
    ``` JSON 
    {
        "name": String,
        "contact_info": String
    }
    ```
    
    object returned by backend: 
    
    ``` JSON 
    { 
        "message": "Profile created!",
        "statusCode": 200,
        "profile_id": String,
    }
    ```
    
 5. #### `getAllProfiles`
    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/getallprofiles

    object sent by backend: A list of all the profiles in the database
    
    ``` JSON 
    {
        "message": "Update saved!", 
        "statusCode": 200,
        [{
            "name": String,
            "contact_info": String
            "profile_id": String
        },
        {
            "name": String,
            "contact_info": String
            "profile_id": String
        },
        {
            "name": String,
            "contact_info": String
            "profile_id": String
        }]
    }
    ```
    
 6. #### `updateProfile` 

    object sent by frontend (send the whole object): 
    
    ``` JSON 
    {
        "name": String,
        "contact_info": String
    }
    
    ```
    
    object sent by backend: 
    
    ``` JSON 
    {
        "message": "Update saved!", 
        "statusCode": 200
    }
    ```
    
 7. #### `createPreSignedURL`

    endpoint url:  https://6yldp7d4wt7pdqucipaows4hge0swfdi.lambda-url.us-west-1.on.aws/ 
    
    object sent by frontend (as POST request): 

    The `interviewContent_type` will be either audio, video, or text. The `interviewFile_format` and `digitalSignatureFile_format` will be format of the url (such as mp3 or mp4). 

    ``` JSON
    {
        "profile_id": String,
        "interviewContent_type": String, 
        "interviewFile_format": String
        "digitalSignatureFile_format": String
        
    }
    ```

    object returned by backend:

    The `interviewSignedURL` will be the URL from the S3 Bucket that will be used to upload media content. The `digitalSignatureSignedURL` will be the URL from the S3 Bucket that will be used to upload the digital signature with every interview.  

    ``` JSON
    {
        "interviewSignedURL": String,
        "digitalSignatureSignedURL": String,
        "interviewFileKey": String,
        "digitalSignatureFileKey": String
    }
    ```

 8. #### `uploadInterviewMedia`
    
    url: the url obtained from the `interviewSignedURL` and `digitalSignatureSignedURL` respectively

    This will be a `PUT` request made by the frontend to upload media content to the S3 Bucket. Two `PUT` requests will be required to handle uploading both the interview and digital signature. 
    
    object sent by frontend: 

    all frontend has to do is upload the file 

    object returned by backend: 

    ``` JSON
    {
        "message": "Uploaded successfully!",
        "status": 200
    }
    ```

 9. #### `createInterview`
    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews
    

    object sent by frontend:

    The `content` and `digital_signature` will be the values from the `interviewFileKey` and `digitalSignatureFileKey` obtained from the backend when the  `createPreSignedURL` request was made.
    
    ``` JSON 
    {
        "profile_id": String, 
        "digital_signature" : String,
        "interview_format" : String,
        "interview_title" : String,
        "interview_content" : String, 
        "interview_description" : String, 
        "is_anonymous" : Boolean
        
    }
    ```
    
    object returned by backend:
    
    ``` JSON
    {
        "message": "Interview created!", 
        "statusCode": 200, 
        "interview_id": String
    }
    ```
10. #### `getInterviews`
 
    endpoint url: https://2jlh65iaqhaadnumtxsdjtahcq0yhjoi.lambda-url.us-west-1.on.aws/
    
    object sent by frontend:

    
    ``` JSON 
    {
        "profile_id": String
    }
    ```
    
    object returned by backend:
    
    An array of all the interviews with that profile_id passed in by the frontend
    
    ```JSON
      [ 
        {
            "interview_title": String,
            "interview_format" : String,
            "interview_date" : date.toISOString(), 
        },
        {
            "interview_title" : String,
            "interview_format" : String,
            "interview_date" : date.toISOString(), 
        },
        {
            "interview_title" : String,
            "interview_format" : String,
            "interview_date" : date.toISOString(), 
        }
      ]
    
    ````
    
 ## Content Managing 
 
 1. #### `content-getAllInterviews`
 
   enpoint url : https://fkoadnxjimanii62ylbdq6it240wglyd.lambda-url.us-west-1.on.aws/
   
   This endpoint will be used for the interviews table on the first page. 
   
   object returned by backend: 
   An array of all interview objects. 
   
   ``` JSON 
      [
        {
         "profile_id": String,
         "interview_id": String,
         "interview_title": String, 
         "interview_status": String,
         "interview_date" : String,
         "interview_format" : String,
         }
         ...
      ]
   ```
   
 The following two endpoints will be used for when an interview is selected from the table. 

2. #### `viewProfileDetails` 
    
    endpoint url: https://57vsoyp55a5jgdt472tjwsi5l40avkbn.lambda-url.us-west-1.on.aws/
    
    alternate url (configured through api gateway): https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/profiles/profile-details
    
    This endpoint will be used to view profile details for a particular interview. 
    
    object sent by frontend:
    
    ```JSON 
    {
       "profile_id": String,
       "interview_id": String
    }
    ```
    
    object sent by backend: 
    
    ```JSON 
    {
       "profile_id": String,
       "name": String,
       "contact_info": String
    }
    ```
    
3. #### `viewInterviewDetails` 
  
    endpoint url: https://dycviqm2d7r5wvkaojst72vide0yvbso.lambda-url.us-west-1.on.aws/
    
    alternate url (configured through api gateway):  https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews/interview-details
    
    This endpoint will be used to view interview details for a particular interview. 
    
    Note that for the interview_content field, frontend will recieve the file key to the S3 bucket. Add this https://testbucket63419.s3.us-west-1.amazonaws.com/ to the front of the file key to obtain the full url of the interview. 
    For example, if the file key from the interview_content field is `990e5e3a-a8af-43ae-ad03-c7fdda1e5e84_Interviews/video/e83d3ea0-a8c8-4387-b6a3-65550685dae1.mp4` then the full url for this interview will be https://testbucket63419.s3.us-west-1.amazonaws.com/990e5e3a-a8af-43ae-ad03-c7fdda1e5e84_Interviews/video/e83d3ea0-a8c8-4387-b6a3-65550685dae1.mp4
    
    object sent by frontend:
    
    ```JSON
    { 
       "profile_id": String,
       "interview_id": String
    }
    ```
    
    
    object returned by backend:
    
    ```JSON 
   {
      "interview_title": String, 
      "interview_content" : String (will be the url to S3 Bucket),
      "interview_description" : String, 
      "interview_date": String,
      "interview_status": String,
      "interview_format": String,
      "is_anonymous": Boolean
      "flagged": Boolean
    }
    ```
    
 4. #### `updateInterviewStatus`

    endpoint url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews/update-status
    
    This endpoint will be used to update the interview status from the interview details page 
    
    object sent by frontend: 
    
    ```JSON 
    {
      "interview_id": String, 
      "interview_status": String,
    }
    ```
    
    object returned by backend:
    
    ```JSON 
    {
       "message": "Interview Status Updated!",
       "statusCode": 200
    }
    ```
    
 5. #### `udpateInterviewFlag` 
    
    endpoint url: https://gtof5fxm76yctedlqxhvsafxp40uqoot.lambda-url.us-west-1.on.aws/
    
    This endpoint will be used to update the interview flag from the interview details page
    
    object sent by frontend:
    
    ```JSON 
    {
       "interview_id": String, 
       "flag": Boolean, 
    }
    ```
    
    object returned by backend: 
    
    ```JSON
    {
       "message": "Interview Flag Updated!", 
       "statusCode": 200
    }
    ```
      
 6. #### `createStory`
    
    endpoint url: https://ablaevqomwtjveizp2faflypp40khwop.lambda-url.us-west-1.on.aws/
    
    This endpoint will be used for when a story is created for a particular interview 
       
     object sent by frontend: 
     
     ```JSON 
     {
        "interview_id": String, 
        "profile_id": String, 
        "story_title": String, 
        "story_content": String, 
        "story_caption": String, 
        "story_status": String (either draft or published),
        "tags": String, 
     }
     ```
     
     object returned by backend
     
     ```JSON
     { 
       "message": "Story successfully saved!",
       "statusCode": 200,
       "story_id": String
     }
     ```
     
  7. #### `getStoryDraftTitles`
   
  endpoint url: https://3mitxjbibzqtrn4c4eermo574m0dmyss.lambda-url.us-west-1.on.aws/
  
  object returned by backend: array of story objects (containing title) that have a status of `drafts` 
  
  ```JSON 
  [ 
     {
       "story_id": String, 
       "story_title": String, 
       "story_status": "draft"
      },
      ...
  ]
  ```
    
  8. #### `getStoryDrafts`
  
  endpoint url: https://atofxysuihvyatot44tk5vhtuy0qlmtw.lambda-url.us-west-1.on.aws/
  
  api gateway url: https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/get-stories/drafts
  
  object returned by backend: array of story objects that have a status of `drafts`
  
  ```JSON
  [
    {
     "story_id": String,
     "story_title": String, 
     "story_content": String, 
     "story_caption": String,
     "story_status": String, 
     "tags": String
    },
    ...
  ]
  ```
  
  ## Stories App 
  
  1. #### `getAllStories`
  
  endpoint url: https://r3gf3sqwyq3um7s3lxg54w3woi0tdhgp.lambda-url.us-west-1.on.aws/
  
  object returned by backend: array of story objects that have a status of `published`
  
  ```JSON 
  [ 
    {
      "story_id": String, 
      "story_title": String,
      "story_content": String,
      "story_caption": String,
      "story_status": String,
      "tags": String 
    }
    ...
  ]
  ```
  

      
  
  
       
    
      
    
   
