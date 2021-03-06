//
//  ViewController.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    var recipeManager = RecipeManager()
    var recipeListManager = SearchRecipeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.randomSegue {
            if let recipeViewController = segue.destination as? RecipeViewController {
                recipeViewController.recipeManager = self.recipeManager
            }
        }
        
        if segue.identifier == Constants.searchSegue {
            if let searchRecipeViewController = segue.destination as? SearchRecipeViewController {
                searchRecipeViewController.recipeListManager = self.recipeListManager
            }
        }
    }


}

