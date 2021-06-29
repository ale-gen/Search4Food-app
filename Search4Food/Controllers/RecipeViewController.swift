//
//  RecipeViewController.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import UIKit
import SDWebImage

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients: [Ingredients] = []
    var servings = 0.0
    
    var recipeManager: RecipeManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeManager!.delegate = self
        tableView.dataSource = self
        
        configureLabel()
        tableView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        
        recipeManager?.fetchRandomRecipe()
    }
    
    func configureLabel() {
        recipeLabel.textAlignment = .center
        recipeLabel.adjustsFontSizeToFitWidth = true
    }
}

extension RecipeViewController: RecipeManagerDelegate {
    func didUpdateRecipe(_ recipeManager: RecipeManager, recipe: RecipeModel) {
        DispatchQueue.main.async {
            print("I am in didUpdateRecipe")
            self.recipeLabel.text = recipe.title
            self.recipeImage.sd_setImage(with: URL(string: recipe.image))
            self.servings = Double(recipe.servings)
            self.ingredients = recipe.ingredients
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ingredientCellIdentifier, for: indexPath) as! IngredientCell
        cell.ingredientNameLabel.text = ingredients[indexPath.row].name
        let amount = ingredients[indexPath.row].amount
        let unit = ingredients[indexPath.row].unit
        cell.ingredientAmountLabel.text = "\(amount) \(unit)"
        return cell
    }
    
}

