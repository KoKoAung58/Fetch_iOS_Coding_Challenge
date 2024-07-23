/**
 *  - Description: A view that provides a search bar for filtering content.
 *
 * -----------------------------------------------------------------------------------
 * Revision History
 * Created Date                        Author                                     Notes
 * -----------------------------------------------------------------------------------
 * July 22nd 2024                     Ko Ko Aung                            Initial Commit
 */


import SwiftUI

struct SearchBar: View {
  /// The search text entered by the user.
  @Binding var text: String
  
  var body: some View {
    HStack {
      ///Placeholder Text in the Search Bar
      TextField("Search...", text: $text)
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
          HStack {
            ///Search Icon
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)
            
            ///Check if the search text field is empty.
            if !text.isEmpty {
              Button(action: {
                self.text = ""
              }) {
                ///Cancel Icon (x)
                Image(systemName: "multiply.circle.fill")
                  .foregroundColor(.gray)
                  .padding(.trailing, 8)
              }
            }
          }
        )
        .padding(.horizontal, 10)
    }
    .padding(.top, 10)
  }
}
