/**
 *  - Description: A view that displays detailed information about a selected meal.
 *
 * -----------------------------------------------------------------------------------
 * Revision History
 * Created Date                        Author                                     Notes
 * -----------------------------------------------------------------------------------
 * July 22nd 2024                     Ko Ko Aung                            Initial Commit
 *
 */


import SwiftUI

struct DetailView: View {
  /// The API service to fetch meal details.
  @ObservedObject var apiService: ApiService
  /// The ID of the meal to display details for.
  let mealID: String
  /// The selected tab in the details view.
  @State private var selectedTab = 0
  
  var body: some View {
    ///Vertical Stack
    VStack {
      if let meal = apiService.selectedMeal {
        ///Scrollable view of Dessert Details
        ScrollView {
          VStack(alignment: .leading, spacing: 16) {
            ///Getting image from URL
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
              image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 5)
            } placeholder: {
              Rectangle()
                .foregroundColor(.gray)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 5)
            }
            
            VStack(alignment: .leading, spacing: 16) {
              /// Dessert Name
              Text(meal.strMeal)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
              
              HStack {
                /**
                 * All these 4 text in this Horizontal Stack are hard coded and won't change
                 * accordingly as the purpose of it is only to make the UI  beautiful
                 */
                
                ///Rating
                Text("⭐️ 4.8")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
                
                Spacer()
                
                ///Time
                Text("15 min |")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
                
                ///Ingredients counts
                Text("5 ingredients |")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
                
                ///Difficulty
                Text("Easy")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
              
              ///Tab picker to change between ingreddients, instructions and reviews
              Picker(selection: $selectedTab, label: Text("Select tab")) {
                Text("Ingredients").tag(0)
                Text("Instructions").tag(1)
                Text("Reviews").tag(2)
              }
              .pickerStyle(SegmentedPickerStyle())
              .padding(.top)
              
              ///Ingredients Tab
              if selectedTab == 0 {
                VStack(alignment: .leading, spacing: 8) {
                  ///Check if there is any ingredients
                  ForEach(meal.ingredients ?? []) { ingredient in
                    ///Ingredient and measurement
                    Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                      .font(.body)
                      .foregroundColor(.primary)
                  }
                }
                ///Instructions Tab
              } else if selectedTab == 1 {
                Text(meal.strInstructions ?? "")
                  .font(.body)
                  .foregroundColor(.primary)
                ///Reviews Tab
              } else {
                Text("No reviews yet...")
                  .font(.body)
                  .foregroundColor(.primary)
              }
            }
            .padding()
          }
          .padding()
        }
        .background(Color(.white).edgesIgnoringSafeArea(.all))
      } else {
        ///if the user doesn't selected a meal/ dessert, it will wait to fetch the meal details
        ProgressView()
          .task {
            await apiService.fetchMealDetails(id: mealID)
          }
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
          Text("Dessert Details")
            .font(.headline)
        }
      }
    }
    ///Fetch the meal details
    .onAppear {
      Task {
        await apiService.fetchMealDetails(id: mealID)
      }
    }
  }
}

///DetailView Preview
struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(apiService: ApiService(), mealID: "53049")
    }
  }
}


