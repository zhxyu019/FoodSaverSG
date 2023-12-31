//
//  FoodSearchView.swift
//  iExpire
//
//  Created by Ma Zhiyu on 18/6/23.
//

import SwiftUI

struct FoodSearchView: View {
    
    @State private var searchText = ""
    @Environment(\.openURL) var openURL
    
    let allfooditemnames = [
        "Rice, 1kg or 2kg",
        "Vermicelli",
        "Bee Hoon",
        "Biscuits, less sugar",
        "Malt Drinks, less sugar",
        "Coffee, less sugar",
        "Tea Satchets",
        "Canned fish",
        "Canned meat",
        "Canned Drinks, beans, mushroom, peas",
        "Canned mock meat",
        "Canned Vegetables",
        "Canned Soup",
        "Canned Fruit",
        "Cooking Oil, 500ml or 1L",
        "Bread Spread",
        "Evaporated/Condensed Milk",
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(filteredNames, id: \.self) { name in
                    HStack{
                        Image(systemName: "checkmark")
                        Text(name)
                    }
                }
                .searchable(text: $searchText, prompt: "Look for food item")
                .navigationTitle("Food Search")
            
                VStack {
                    Spacer()
                    HStack {
                       // Spacer()
                        Button(action: {
                            // blah blah
                            openURL(URL(string: "https://www.google.com")!)
                        }, label: {
                            Text("Google")
                                .font(.system(size:20))
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color.white)
                                .padding(7)
                        })
                        .background(Color.accentColor)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        .frame(width: 350, alignment: .trailing)
                    }
                }
            }
        }
}
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allfooditemnames
        } else {
            return allfooditemnames.filter{$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct FoodSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchView()
    }
}
