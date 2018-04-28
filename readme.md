[![Heroku](https://heroku-badge.herokuapp.com/?app=scuteser)](https://scuteser.herokuapp.com)  

<a href="https://codeclimate.com/github/jwhaosis/nano-twitter/maintainability"><img src="https://api.codeclimate.com/v1/badges/cc51915e6977d75f79fe/maintainability" /></a>

#NanoTwitter App
##Authors
Shu Lin Chan,
Priyanka Grover,
James Wang
COSI105B, Spring 2018

Heroku
http://scuteser.herokuapp.com/

Heroku with load balancing or for mass test interface calls
http://scutesermaster.herokuapp.com/

###To deploy
clone this app from github: https://github.com/jwhaosis/nano-twitter

1. To run this locally, do this in your terminal:
``````bundle install``````
2. To create the schema, run:
`````rake db:migrate`````
3. To start the server, run:
````rackup````
4. To seed the data, start the server then path to:
````<localhost>/test/reset/standard?users=<u>&tweets=<t>&followers=<f>````
Note: rake db:seed will give an incomplete set of records


External parts of the project:
- Portfolio (https://groverpriyanka.github.io/scuteser) - Priyanka
- Load Balancer (https://github.com/jwhaosis/scutesermaster) - James
- Database Backend (https://github.com/jwhaosis/scuteserdatabase) - James


##Change History
nanoTwitter 0.1: Foundation
1. Dir - James
2. DB Schema - Shu Lin
3. UI Design - Priyanka, Shu Lin
4. Routes - James

nanoTwitter 0.2: MVP - First Minimal Implementation
1. Sinatra - James
2. Migrations - Shu Lin
3. Authentication - Shu Lin
4. Heroku - James

nanoTwitter 0.3: Core functionality
1. Unit Tests - Priyanka
2. Test Interface - James
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
2. Loader - James, Priyanka
3. New Relic - James, Shu Lin
4. Improve Schema - Shu Lin

nanoTwitter 0.6 - Advanced Scaling
1. Redis - James, Shu Lin
2. Caching - James, Shu Lin
3. Scale Experiment - James

nanoTwitter 0.7 - Web Service API & Client
1. API Routes - James
2. Client Lib - James
3. Client Lib Test - James
4. Testing - Priyanka
5. Portfolio - Priyanka

nanoTwitter 1.0: Completion
1. Microservice = James, Shu Lin
2. Codeclimate - Priyanka
3. UI clean up = Shu Lin
4. Preparation for spinoff - James
5. Final Review - James, Shu Lin, Priyanka

