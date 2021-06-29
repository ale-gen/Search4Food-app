//
//  IngredientCell.swift
//  Search4Food
//
//  Created by Aleksandra Generowicz on 29/06/2021.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var ingredientBubble: UIView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientAmountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientBubble.layer.cornerRadius = ingredientBubble.frame.height / 5
        ingredientNameLabel.adjustsFontSizeToFitWidth = true
        ingredientAmountLabel.adjustsFontSizeToFitWidth = true
        ingredientAmountLabel.textAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
