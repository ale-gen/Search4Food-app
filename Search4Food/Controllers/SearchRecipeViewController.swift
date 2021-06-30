//
//  SearchRecipeViewController.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 30/06/2021.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var recipes: [SingleRecipe] = []
    var recipeListManager: SearchRecipeManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeListManager!.delegate = self
        tableView.dataSource = self
        textField.delegate = self
    }
}

extension SearchRecipeViewController: SearchRecipeManagerDelegate {
    func didUpdateRecipesList(_ searchRecipeManager: SearchRecipeManager, recipeList: RecipeListModel) {
        DispatchQueue.main.async {
            self.recipes = recipeList.recipes
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension SearchRecipeViewController: UITextFieldDelegate {
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter recipe"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let recipe = textField.text {
            recipeListManager?.fetchRecipesList(recipe: recipe)
        }
        
        textField.text = ""
    }
    
}

extension SearchRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipes.count)
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.singleSearchedRecipeCellIdentifier, for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].title
        return cell
    }
    
    
}


