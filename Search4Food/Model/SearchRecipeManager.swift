//
//  SearchRecipeManager.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 30/06/2021.
//

import Foundation

protocol SearchRecipeManagerDelegate {
    func didUpdateRecipesList(_ searchRecipeManager: SearchRecipeManager, recipeList: RecipeListModel)
    func didFailWithError(error: Error)
}

struct SearchRecipeManager {
    var recipeURL: String {
        return "https://api.spoonacular.com/recipes/"
    }
    
    var delegate: SearchRecipeManagerDelegate?
    
    func fetchRecipesList(recipe: String) {
        let url = "\(recipeURL)complexSearch?apiKey=\(Constants.apiKey)&query=\(recipe)"
        performRecipesList(with: url)
    }
    
    func performRecipesList(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let correctData = data {
                    if let recipeList = self.parseJSON(correctData) {
                        self.delegate?.didUpdateRecipesList(self, recipeList: recipeList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ recipeData: Data) -> RecipeListModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeListData.self, from: recipeData)
            let recipesNumber = decodedData.totalResults
            let recipes = decodedData.results
            
            let recipesList = RecipeListModel(recipesNumber: recipesNumber, recipes: recipes)
            print(recipesList)
            return recipesList
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

