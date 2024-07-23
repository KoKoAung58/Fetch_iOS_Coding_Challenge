/**
 *  - Description: Api Service class responsible for fetching the data from the server via api and formatting into struct
 * to be consumed by the views.
 *
 * -----------------------------------------------------------------------------------
 * Revision History
 * Created Date                        Author                                     Notes
 * -----------------------------------------------------------------------------------
 * July 22nd 2024                     Ko Ko Aung                            Initial Commit
 */

// MARK: - Import Statements
import Foundation
import Combine

class ApiService: ObservableObject {
  /**
   * Published property that contains the list of meals.
   * Published property that contains the selected meal details.
   */
  @Published var meals: [Meal] = []
  @Published var selectedMeal: Meal?

  // MARK: - fetchMeals
  /**
   * Fetches a list of dessert meals from the API.
   *
   * - Returns :void
   */
  func fetchMeals() async {
    
    /// URL contruct
    guard let url =
        URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    else { return }

    do {
      /// Perform the network request to fetch meals (desserts)
      let (data, _) = try await URLSession.shared.data(from: url)
      
      /// Decode the JSON response into a MealResults object
      let results = try JSONDecoder().decode(MealResults.self, from: data)
      
      /// Update the meals property
      DispatchQueue.main.async {
        self.meals = results.meals.sorted { $0.strMeal < $1.strMeal }
      }
    } catch {
      print("Error fetching meals: \(error)")
    }
  }

  // MARK: - fetchMealDetails
  /**
   * Fetches single meal detail from the url for detail view.
   *
   *  - Parameters:
   *  - id {String} : Id of the meal which is used to retrieve the details.
   *
   *  - Returns :void.
   */
  func fetchMealDetails(id: String) async {
    
    /// Clear the selectedMeal before fetching another meal.
    DispatchQueue.main.async {
      self.selectedMeal = nil
    }
        
    /// URL contruct
    guard let url =
        URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
    else { return }

    
    do {
      /// Perform the network request to fetch meal details
      let (data, _) = try await URLSession.shared.data(from: url)
      
      /// Decode the JSON response into a MealResults object
      let results = try JSONDecoder().decode(MealResults.self, from: data)

      /// If the results contain at least one meal, update the selectedMeal property
      if let meal = results.meals.first {
        DispatchQueue.main.async {
          self.selectedMeal = meal
        }
      }
    } catch {
      /// Print an error message if fetching meal details fails
      print("Error fetching meal details: \(error)")
    }
  }

  // MARK: - clearSelectedMeal
  /**
   * Clears the meal after user returned from detail view.
   *
   *  - Returns:void.
   */
  func clearSelectedMeal() {
    self.selectedMeal = nil
  }
}



