Shu Lin Chan, Priyanka Grover, James Wang
13.2

## **Tweets**
- GET tweet
 * *Description*: Returns a tweet with the given tweet number.
 * *Example Request*: GET https://scuteser.herokuapp.com/api/vi/{apitoken}/tweets/23
- GET recent_tweets
 * *Description*: Returns all recent tweets made by any user (up to 50).
 * *Example Request*: GET https://scuteser.herokuapp.com/api/vi/{apitoken}/tweets/recent
- POST tweet
 * *Description*: Creates a tweet
 * *Example Request*: POST https://scuteser.herokuapp.com/api/vi/{apitoken}/tweets/new
- DELETE tweet
 * *Description*: Deletes a tweet with the given tweet number.
 * *Example Request*: POST https://scuteser.herokuapp.com/api/vi/{apitoken}/tweets/23/delete

## **Users**
- GET user
 * *Description*: Returns a user with the given user number.
 * *Example Request*: GET https://scuteser.herokuapp.com/api/vi/{apitoken}/users/23

- GET user_tweets
 * *Description*: Returns the recent tweets of a given user number (up to 50)
 * *Example Request*: GET https://scuteser.herokuapp.com/api/vi/{apitoken}/users/23/tweets
