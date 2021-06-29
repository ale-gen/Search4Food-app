//
//  RecipeData.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import Foundation

struct RecipeData: Codable {
    let recipes: [Recipes]
}

struct Recipes: Codable {
    let vegetarian: Bool
    let vegan: Bool
    let extendedIngredients: [Ingredients]
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    let analyzedInstructions: [AnalyzedInstructions]
}

struct Ingredients: Codable {
    let name: String
    let amount: Double
    let unit: String
}

struct AnalyzedInstructions: Codable {
    let steps: [Steps]
}

struct Steps: Codable {
    let step: String
}
