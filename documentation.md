# Database Schema 

Below is the database schema for the entire project. Four key tables will be used: **user**, **profile**, **interview**, and **stories**, across all applications made. The user table will consist of data pertaining to the admin team for them to create an account and log in. The profile table will consist of personal information pertaining to the participant being interviewed. The interview table will consist of all relevant data about the interview, as it is taken. And finally, the stories table will contain all data pertinent to the story that will ultimately feature the stories application. The ids in every table will help providing an unique identifier for every new iterm

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
| digital_singature | String |
| format | String | 
| title  | String |
| description | String |
| content | String |
| date    | String |
| status  | String |
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
| tags    | String |




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

| interview_id  | profile_id   | format  | title | content | description | date | digital_signature | is_anonymous | status | flagged
| :---     | :---    | :---      | :---      | :---      | :---    | :---   | :---   | :---  | :---  | :---
| "8922c504-68d4-4c13-88fa-c05f271803b4" | "e9a94732-176e-4b4b-bf03-32461ada23bb" | "video" | "Health update" | "url.mp4" | "Participant discusses health issues ... " | "December 21, 2022" | "url.mp4" | true | "pending" | false | 


### sample stories table 

The `story_id` will be auto-generated, and an existing `interview_id` and `profile_id` will be matched to the table. The `story_status` can either be `published` or `draft`. 

| story_id  | interview_id   | profile_id  | story_title | story_caption | story_content | tags | story_status 
| :---     | :---    | :---      | :---      | :---      | :---    | :---   | :---   
| "93db2af2-ce28-424a-b12c-822be27e671d" | "8922c504-68d4-4c13-88fa-c05f271803b4" | "e9a94732-176e-4b4b-bf03-32461ada23bb" | "Growing Health Concerns in Uganda" | "Learn about health issues with pregnancy" | "In an interview with... " | "health" | "published" |


# Endpoints 

## Interview 

1. #### `createUser`
    endpoint url: https://y2rucoc6kiwrvvt4xqnfektnwi0dwqnz.lambda-url.us-west-1.on.aws/
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
      "user_id" : String
    } 
    ```
    
    
2. #### `getUser`
    endpoint url: https://nokdeyzkn7r4vbm5jp6ktpffae0svcvg.lambda-url.us-west-1.on.aws/
     object sent by frontend (use `POST` request): 
    
    ``` JSON 
    {
      "user_id": String,
      "email": String,
      "password": String
    }
    ```
    
    object returned by backend: 
    
    ``` JSON 
    {
      "message" : "Login successful!",
      "statusCode" : 200,
      
    } 
    ```
    
3. #### `createProfile`
    endpoint url: https://gwl2m3ztomvuaz62gzm2cp3gey0ispie.lambda-url.us-west-1.on.aws/

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
    
 4. #### `getProfile`
    endpoint url: https://7wtpsdk6azrf5lltdgxpj4xsgi0ceelm.lambda-url.us-west-1.on.aws/

    object sent by backend: 
    
    ``` JSON 
    {
        "name": String,
        "contact_info": String
    }
    ```
    
 5. #### `updateProfile` 

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
    
 6. #### `createInterview`
    endpoint url: https://s4bh4zczxpw4imhwzb5ixhfccm0vzvxe.lambda-url.us-west-1.on.aws/
    
    object sent by frontend:
    
    ``` JSON 
    {
        "profile_id": String, 
        "format" : String,
        "title" : String,
        "content" : String, 
        "description" : String, 
        "is_anonymous" : Boolean,
        "digital_signature" : String,
    }
    ```
    
    object sent by backend:
    
    ``` JSON
    {
        "message": "Interview created!", 
        "statusCode": 200, 
        "interview_id": String
    }
    ```
  

    
