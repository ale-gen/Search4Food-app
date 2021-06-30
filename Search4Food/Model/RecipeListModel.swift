//
//  RecipeListModel.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 30/06/2021.
//

import Foundation

struct RecipeListModel {
    let recipesNumber: Int
    let recipes: [SingleRecipe]
    
    var description: String {
        return "Recipes number: \(recipesNumber), recipes: \(recipes)"
    }
}
