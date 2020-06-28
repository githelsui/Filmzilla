# Project 2 - *Filmzilla*

**Filmzilla** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:
- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] In Detail Vuew, User can tap a Read button that redirects them to the Review Screen (API request using getReview)
- [x] In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer
- [x] Users can add a movie to their watchlist by clicking the heart button
- [x] The Watchlist view fetches the array of movies liked by the user, saved in the User Defaults
- [x] The Recommendation Screen showcases recommended movies fetched using the getRecommendations endpoint from the API
- [x] User can delete a movie in their watchlist and the screen will update when they  refresh.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Can we go over the specifics of the network call to the API
2. Storing an NSArray using UserDefaults. I want to utilize this functionality in order to save movies in a favorites section.
3. Auto layout and how we can start implementing this feature in order to make better UI.

## Video Walkthrough

Here's a walkthrough of implemented user stories:
<img src="gif1.gif" width="250" height="250"/>

## Notes

Describe any challenges encountered while building the app.
- Implementing the search function due to a lack of knowledge of Objective-C syntax
- Network call difficulties either with the URL or other errors
- Having constant nil exceptions or conversion errors between types
- Passing data from one view to another
- Trying to save an NSArray into User Defaults
- Creating an action button within a Table View Cell
- Having the Activity Indicator show up at the right times.
- Having the Alert Message appear only when there is no network 
- The syntax and procedures of setting up a table view cell's interface elements with items in an NSArray

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
