#NanoTwitter App
##Authors
Shu Lin Chan,
Priyanka Grover,
James Wang
COSI105B, Spring 2018

###Heroku
http://scuteser.herokuapp.com/

###To deploy
clone this app from github: https://github.com/jwhaosis/nano-twitter

1. To run this locally, do this in your terminal:
``````bundle install``````
2. To create the schema, run:
`````rake db:migrate`````
3. To seed the data, run:
````rake db:seed````
4. To start the server, run:
````rackup````


##Change History
nanoTwitter 0.1: Foundation
1. Dir - James
2. DB Schema - Shu Lin
3. UI Design - Priyanka
4. Routes - James

nanoTwitter 0.2: MVP - First Minimal Implementation
1. Sinatra - James
2. Migrations - Shu Lin
3. Authentication - Shu Lin
4. Heroku - James

nanoTwitter 0.3: Core functionality
1. Unit Tests - Priyanka
2. Test Interface - Shu Lin, James
3. Codeship - James
4. Standard Seeds - Shu Lin
5. Autodeploy (Codeship to Heroku) - James

nanoTwitter 0.4: Testing and Deployment
1. Manual Test - Shu Lin 
2. Test Interface - James
3. Load Test - James
4. More Tests - Priyanka

nanoTwitter 0.5 - Inital Load Testing
1. Load Testing  - James
2. Loader - James and Priyanka
3. New Web - James and Shu Lin
4. Improve Schema - Shu Lin

nanoTwitter 0.6 - Advanced Scaling
1. Redis - James, Shu Lin
2. Caching - James, Shu Lin
3. Scale Experiment - James

nanoTwitter 0.7 - Web Service API & Client
1. API Routes -
2. Client Lib - 
3. Client Lib Test