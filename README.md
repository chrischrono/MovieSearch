Movie Search
===========

This repository contains a sample app for requesting TMDb API, to search for movies.


---
# Existing Functionalities

The app is currently able to Search Movies from TMDb API, and show it in tableView.

* When the app loads, it will Search the Movies from TMDb API, and show them in the tableView
* Upon changing the Search Query, it will try to refresh the list with related movies based on the new query to TMDb API

---
# Development Steps

1. Create new project based on single view app
2. Create folders for MVVM pattern
3. Add MovieSearchViewController and Design the UI layout to show Movie List
4. Add Networking Layer to handle the TMDb API
5. Add Models and ViewModel, that will show the Movie List at MovieSearchViewController
6. Add simple get and cache Movie's Poster Images feature
7. Add Unit Tests to test the process

---
# Next Improvements 

1. More responsive Network handling (eg. Automatic retry when Internet connection detected)
2. Add more information on each movie, that user might need.
3. Continuous load of the movie list
4. Cached image to files
5. Resize image to optimize memory consumption




