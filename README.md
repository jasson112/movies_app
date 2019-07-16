# Questions and answers

# Application Layers:
## Presentation Layer
  - Movies List View
  - Tab Category View
  - Detail View
  - Video View
## Bussiness Layer
#### Movies List View
- Fecth List of movies of an API
- When someone search the app will fetch to server trough AppDelegate block function
- When someone click a movie picture they go to Moview Detail View
#### Tab Category View
- Create 3 tabs for movie category using Moview List View as reference
#### Detail View
- Shows data sended from movie list view to the user
- Shows a link that redirect the user to youtube to see the trailer video trough web view
## Persitence Layer
- All request are async background task trough AppDelegate
- Fetch Api getting the list of movies
- Fetch URL getting the image of certain movie
- Fetch Api getting the list of movies based on certain query for search
## Data Layer
- All data (calling the API or load an image) are fetch and saved into cache and then if the user enter again into the app the data is loaded more faster from the cache and aswell the app later works without internet connection 

# Class responsabilities:
## NavigationController
- This is responsible of controlling the flow of the app letting see the top bar and back button
## ViewController
- This is responsible of functionality of the movie list, listing movies and getting data from the API and this have a connection with DetailController sending data to show details to the users
## DetailViewController
- This is responsible of functionality of showing detail data of the movie getting the data sended from de movie list
## CategoryViewController
- This is responsible of show categories and creating and adding the other view controllers based on Movie list 
## MovieDetailSegue
- This controls the custom segue with custom animation used when the user goes to the detail view
## BackDetail
- This controls the custom segue with custom animation used when the user rolls back to the movie list
## MovieCell
- This reference all the objects used to show every item in the movie list (imageview and label)
## AppDelegate
- This has been modified adding 3 blocks, first for fech api for movie list, second for fetch images called in the list and detail views and finally for fecth the searching of movies(online and offline)

# Single Responsability Principle in my words:
- Is the connection of modules and classes with an unique propourse with the objective of avoid the overlapping of the application layers
# A good looking code:
A good loking code needs to have:
- Comments
- Good desing pattern
- Good architecture pattern
- No duplicates in methods or functions
- Reusability of code
- Less is more in functions, methods and variables
