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
    
    var recipeManager: RecipeManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeManager!.delegate = self
        
        configureLabel()
        
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
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

