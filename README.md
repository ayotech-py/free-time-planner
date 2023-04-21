# Free Time Planner - AI Powered Tourist Attraction Recommendation System

## Introduction:

The Free Time Planner is a mobile application built using Flutter, which provides personalized tourist attraction recommendations based on user input, including available time, budget, location and keyword filters. The app uses an AI-powered recommendation system that utilizes data from various sources such as user browser history, social media activities, purchase history, and feedback (ratings) from users to improve the recommendations.

## Data:

The AI model used in the Free Time Planner app utilizes a dataset with 11 columns and about 242 rows. The dataset includes information such as the name, address, location (latitude and longitude), rating, total ratings, type, price, region, and country of various tourist attractions. This information is used by the recommendation system to provide personalized recommendations to users based on their input.

## Features:

The Free Time Planner app offers various features to users, including:

- Personalized tourist attraction recommendations based on user input and feedback

- Keyword filters based on user browser history, social media activities, and purchase history

- User-friendly interface with easy navigation

- Real-time updates based on user feedback

## Architecture:

The Free Time Planner app is built using the Flutter framework, which allows for seamless development across multiple platforms. The AI model used in the app is trained on the dataset mentioned earlier and utilizes machine learning algorithms to provide personalized recommendations to users. The app also uses APIs to collect data from various sources, including user browser history, social media activities, and purchase history.

## Backend Services

The Free Time Planner app was built majorly with flutter which was connected to two backend services which are:
**The Firebase Service:**
Firebase is a backend service powered by google which can be used for various backend activities. In this project, firebase was used for:

- Authentication and Authorization of Users: Users details such as email, password, fullname, age are stored on firebase database and the app uses firebase to authenticate and authorize previous users whenever they plan to login again.
- Database Management: Users details are also stored on the database such as field mentioned above and also the users location, browser historys, comments and ratings

**Django Backend Service:**
Django is a python webframework used as a backend webservice to power frontend applications. In this project, django was used to build the AI recommendation system. the AI recommendation system was built using different libraries such as

- djangorestframework
- geographiclib
- geopy
- numpy
- pandas
- scikit-learn

All the above libraries was used in building a model which was trained using the aforementioned dataset. the model accepts all type of inputs, process it and returns the output in a json format.

Djangorestframework is a django based framework used in building APIs(Application Programming Interface). inputs are passed to the model via the API and the output are also rendered to the App via the API which was hosted on Railway Hosting Platform and the API can be accesed using this link [https://touristattractionapi-production.up.railway.app/places/tourist_search/].

## Conclusion:

The Free Time Planner app is a user-friendly and AI-powered tourist attraction recommendation system that provides personalized recommendations based on user input and feedback. The app's architecture and machine learning algorithms ensure that users receive the most relevant recommendations based on their preferences and feedback
