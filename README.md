# Project 3 - **Foodda**

![fooddaicon2small](https://cloud.githubusercontent.com/assets/11231583/22946977/4ad70fd6-f2c7-11e6-9dcb-55ec4e866582.png)


**Foodda** is a Yelp search app using:
- [Yelp Search API](http://www.yelp.com/developers/documentation/v2/search_api).
- [Yelp Business API](http://www.yelp.com/developers/documentation/v2/business).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Table rows for search results should be dynamic height according to the content height.
- [X] Custom cells should have the proper Auto Layout constraints.
- [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).

The following **optional** features are implemented:

- [X] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [X] Implement map view of restaurant results.
- [X] Implement the restaurant detail page.

The following **additional** features are implemented:

- [X] Access phone number information for details page from Search API
- [X] Adding loading indicator - "DotsLoader" Copyright © 2016 Mathieu Bolard
- [X] Added Review Table
   - [X] Custom call to Business API with verification; got reviews for data source from request
- [X] Extends the fixed location: Can now use the user's location
   - [X] Proper permissions included

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Extendability with updated Yelp API.
2. Going in depth with the oauth required by Yelp API for data requests.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![fooddahurtadogif2](https://cloud.githubusercontent.com/assets/11231583/23105302/39835a54-f6ab-11e6-8e9d-a86372425171.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- Initiating another request was difficult being that I was not too familiar with the format of requesting the information.

## License

    Copyright [2017] [Steven Hurtado]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
