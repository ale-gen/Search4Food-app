//
//  RecipeListData.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 30/06/2021.
//

import Foundation

struct RecipeListData: Codable {
    let results: [SingleRecipe]
    let totalResults: Int
}

struct SingleRecipe: Codable {
    let id: Int
    let title: String
}
