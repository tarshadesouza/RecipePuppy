//
//  RecipeCell.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 07/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import UIKit
import Foundation

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureCell(thumbnail: String, title: String, ingredients: String) {
        self.title.text = title
        self.ingredients.text = ingredients
        setUpThumbnailImg(url: thumbnail)
    }
    
    
    func setUpThumbnailImg(url: String?) {
        if let thumbnail = url {
            let img = self.thumbnail.loadImage(imageObject: thumbnail)
            self.thumbnail.image = img
        }
    }
    
    
    
}




