//
//  RecipeModel.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import Foundation

struct RecipeModel {
    let title: String
    let vegetarian: Bool
    let vegan: Bool
    let servings: Int
    let ingredients: [Ingredients]
    let image: String
    
    var description: String {
        return "Title: \(title), vegetarian: \(vegetarian), vegan: \(vegan), servings: \(servings), ingredients: \(ingredients), image: \(image)"
    }
}
