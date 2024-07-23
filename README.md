# Dessert Recipes App

## Project Description

The **Dessert Recipes App** is a native iOS application that allows users to browse and search for dessert recipes. Users can view detailed information about each recipe, including ingredients, cooking instructions, and reviews. This app aims to provide a delightful user experience for dessert enthusiasts, leveraging the `themealdb.com` API for its data.


### What your application does
- Browse a list of dessert recipes
- Search for recipes by name
- View detailed information about each recipe, including ingredients and instructions
- Dynamic filtering of recipes based on search input
- Clean and user-friendly interface

## Classes
|File Name       | Description                                      |
|----------------|--------------------------------------------------|
|MealData        | Data Structure for all the meals and meal details|
|ApiService     | JSON Decoding and API Fetching                   |
|ContentView    | Home Screen UI                                   |
|DetailView     | Meal Details UI                                  |
|SearchBar | Search Bar UI Component |

### Why you used the technologies you used
- **SwiftUI**: For building a responsive and modern user interface.
- **Combine**: For managing asynchronous operations and data flow.
- **TheMealDB API**: For fetching a wide variety of dessert recipes.

### Some of the challenges you faced and features you hope to implement in the future
- **Challenges**: Integrating with the API and managing state across the application.
- **Future Features**: Adding user authentication, enabling user-generated content such as reviews and ratings, and integrating with a local database for offline access.

## Table of Contents (Optional)

1. [Project Description](#project-description)
2. [How to Install and Run the Project](#how-to-install-and-run-the-project)
3. [How to Use the Project](#how-to-use-the-project)
4. [Credits](#credits)

## How to Install and Run the Project

### Prerequisites

- Xcode 12.0 or later
- iOS 14.0 or later

### Steps

1. Clone the repository:
   ```sh
   git clone https://github.com/KoKoAung58/Fetch_iOS_Coding_Challenge.git
2. Open the project in Xcode:
   cd dessert-recipes-app
   open DessertRecipesApp.xcodeproj
3. Build and run the app on the simulator or a physical device.

## How to Use the Project
**Home Screen**
- The home screen displays a list of dessert recipes fetched from the API.
- Users can search for recipes using the search bar at the top.
**Detail Screen**
- Tapping on a recipe navigates to the detail screen.
- The detail screen displays:
- Recipe name
- Recipe image
- Ingredients and their measurements
- Cooking instructions
- Reviews (Placeholder for now)

## Credits
This project was developed by Ko Ko Aung.


