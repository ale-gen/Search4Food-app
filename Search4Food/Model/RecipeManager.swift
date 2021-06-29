//
//  RecipeManager.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import Foundation

protocol RecipeManagerDelegate {
    func didUpdateRecipe(_ recipeManager: RecipeManager, recipe: RecipeModel)
    func didFailWithError(error: Error)
}

struct RecipeManager {
    var recipeURL: String {
        return "https://api.spoonacular.com/recipes/"
    }
    
    var delegate: RecipeManagerDelegate?
    
    func fetchRandomRecipe() {
        let url = "\(recipeURL)random?apiKey=\(Constants.apiKey)"
        performRecipe(with: url)
    }
    
    func performRecipe(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let correctData = data {
                    if let recipe = self.parseJSON(correctData) {
                        self.delegate?.didUpdateRecipe(self, recipe: recipe)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ recipeData: Data) -> RecipeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            let vegetarian = decodedData.recipes[0].vegetarian
            let vegan = decodedData.recipes[0].vegan
            let title = decodedData.recipes[0].title
            let servings = decodedData.recipes[0].servings
            let extendedIngredients = decodedData.recipes[0].extendedIngredients
            let imageURL = decodedData.recipes[0].image
            
            let recipe = RecipeModel(title: title, vegetarian: vegetarian, vegan: vegan, servings: servings, ingredients: extendedIngredients, image: imageURL)
            print(recipe.description)
            return recipe
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
