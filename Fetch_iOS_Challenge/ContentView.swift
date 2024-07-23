/**
 *  - Description: A view that displays a list of dessert recipes and allows searching through them.
 *
 * -----------------------------------------------------------------------------------
 * Revision History
 * Created Date                        Author                                     Notes
 * -----------------------------------------------------------------------------------
 * July 22nd 2024                     Ko Ko Aung                            Initial Commit
 *
 */

import SwiftUI

struct ContentView: View {
  /// The API service to fetch meals data.
  @StateObject private var apiService = ApiService()
  /// The search query entered by the user.
  @State private var searchQuery = ""
  
  //MARK: - All Meal
  var body: some View {
    NavigationView {
      VStack {
        /// Search Bar
        SearchBar(text: $searchQuery)
        
        /// Scrollable list of meals
        ScrollView {
          ///Lazy loading Vertical Stack
          LazyVStack(spacing: 20) {
            ForEach(filteredMeals) { meal in
              ///Directing to the Detail View of the selected Dessert/ Meal
              NavigationLink(destination: DetailView(apiService: apiService,
                                                     mealID: meal.idMeal)) {
                MealRow(meal: meal)/// Loading each Meal/ Dessert
              }
            }
          }
          .padding(.horizontal)
        }
      }
      
      ///Navigation items : App Icon and Navigation Title
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          HStack {
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
              .resizable()
              .frame(width: 40, height: 40)
              .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("Dessert Recipes")
              .font(.headline)
          }
        }
      }
      .task {
        await apiService.fetchMeals() /// Fetch all Meals/ Desserts
      }
      .onAppear {
        ///Clear the selected meal when user comes back to content view
        apiService.clearSelectedMeal()
      }
    }
  }
  
  //MARK: - Search Query
  /// Filtered meals based on search query
  private var filteredMeals: [Meal] {
    if searchQuery.isEmpty {
      return apiService.meals
    } else {
      return apiService.meals.filter {
        $0.strMeal.lowercased().hasPrefix(searchQuery.lowercased())
      }
    }
  }
}


//MARK: - Each Meal Row
/// A view that displays the details of a meal.
struct MealRow: View {
  /// The meal to display.
  let meal: Meal
  
  var body: some View {
    VStack(alignment: .leading) {
      ///Image Loaded from the URL
      AsyncImage(url: URL(string: meal.strMealThumb)) { image in
        image.resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 200)
          .clipped()
      } placeholder: {
        Rectangle()
          .foregroundColor(.gray)
          .frame(height: 200)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        ///Dessert Name
        Text(meal.strMeal)
          .font(.title2)
          .fontWeight(.bold)
          .foregroundColor(.primary)
        
        Text("Tap to view details")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      .padding()
    }
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 5)
  }
}

///ContentView Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
