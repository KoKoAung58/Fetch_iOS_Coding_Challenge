/**
 *  - Description: The `MealData` struct includes information about a meal such as its ID, name, thumbnail image URL,
 *  cooking instructions, and a list of ingredients with their measurements. This struct is used to
 *  decode JSON responses from the meal API.
 *
 * -----------------------------------------------------------------------------------
 * Revision History
 * Created Date                        Author                                     Notes
 * -----------------------------------------------------------------------------------
 * July 22nd 2024                     Ko Ko Aung                            Initial Commit
 */

import Foundation

// MARK: - MealResults struct
/// A structure representing the results of a meal fetch operation.
struct MealResults: Decodable {
  /// The list of meals returned by the API.
  let meals: [Meal]
}

// MARK: - Meal struct
/// A structure representing the meal fetched
struct Meal: Decodable, Identifiable {
  var id: String {
    return idMeal
  }
  let idMeal: String
  let strMeal: String
  let strMealThumb: String
  let strInstructions: String?
  let ingredients: [Ingredient]?
  
  /**
   * - Description : Initializes a new `MealData` instance by decoding from a decoder.
   * This initializer decodes a JSON object and extracts values for the meal's ID, name, thumbnail URL,
   * cooking instructions, and ingredients with their measurements. The ingredients and their measurements
   * are dynamically decoded from keys named "strIngredient1", "strIngredient2", ..., "strIngredient20" and
   * "strMeasure1", "strMeasure2", ..., "strMeasure20".
   *
   * - Parameter decoder {Decoder}: The decoder to decode data from.
   * - Throws: An error if any value throws an error during decoding.
   */
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    idMeal = try container.decode(String.self, forKey: .idMeal)
    strMeal = try container.decode(String.self, forKey: .strMeal)
    strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
    strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
    
    ingredients = try? (1...20).compactMap { index in
      guard 
        let ingredient = try container.decodeIfPresent(String.self,
            forKey: CodingKeys(stringValue: "strIngredient\(index)")!),
        let measure = try container.decodeIfPresent(String.self,
            forKey: CodingKeys(stringValue: "strMeasure\(index)")!),
        !ingredient.isEmpty,
        !measure.isEmpty else { return nil }
      
      return Ingredient(ingredientName: ingredient, measurement: measure)
    }
  }
  
  // MARK: - CodingKeys Enum
  /**
   * A private enum used to map JSON keys to properties.
   * This enum includes keys for the meal's ID, name, thumbnail URL, cooking instructions,
   * and up to 20 ingredients and their measurements.
   */
  private enum CodingKeys: String, CodingKey {
    case idMeal, strMeal, strMealThumb, strInstructions
    case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
    case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
    case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
    case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
    case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
    case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
    case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
    case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
  }
}

// MARK: - Ingredient struct
/**
 * A structure representing an ingredient and its measurement.
 *
 * The `Ingredient` struct includes the name of the ingredient and its measurement. This struct is used
 * to decode JSON responses from the meal API and associate each ingredient with its corresponding measurement.
 */
struct Ingredient: Decodable, Identifiable {
  var id = UUID()
  var ingredientName: String
  var measurement: String
}
