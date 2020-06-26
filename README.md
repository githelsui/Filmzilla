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

- [x] In Details Screen, User can tap a Read button that redirects them to the Review Screen (API request using getReview)
- [x] In a separate tab (the Watchlist Screen), movies are fetched from the API using the getUpComingMovies method

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Can we go over the specifics of the network call to the API
2. Storing an NSArray using UserDefaults. I want to utilize this functionality in order to save movies in a favorites section.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![](gif1.gif) ![](gif2.gif) ![](gif3.gif) ![](gif4.gif)

## Notes

Describe any challenges encountered while building the app.
- Implementing the search function due to a lack of knowledge of Objective-C syntax
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
