//
//  RecipeViewController.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import UIKit
import SDWebImage
import MKStepper

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stepperView: MKStepperView!
    
    var ingredients: [Ingredients] = []
    var servings = 0.0
    
    var recipeManager: RecipeManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeManager!.delegate = self
        tableView.dataSource = self
        stepperView.delegate = self
        
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
        let newServings = Double(stepperView.stepperValue)
        let amount = round(100 * (ingredients[indexPath.row].amount * newServings) / self.servings) / 100
        let unit = ingredients[indexPath.row].unit
        cell.ingredientAmountLabel.text = "\(amount) \(unit)"
        return cell
    }
    
}

extension RecipeViewController: StepperViewDelegate {
    func valueDidChange(value: Int) {
        tableView.reloadData()
    }
    
    func reachedAtMin(value: Int) {
        let alert = UIAlertController(title: "Minimum value of servings was reached.", message: "It is available to set ingredients' amount for 1 to 40 servings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func reachedAtMax(value: Int) {
        let alert = UIAlertController(title: "Maximum value of servings was reached.", message: "It is available to set ingredients' amount for 1 to 40 servings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
}

