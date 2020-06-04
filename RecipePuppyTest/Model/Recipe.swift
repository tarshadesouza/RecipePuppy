//
//  Recipe.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 06/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import SwiftyJSON



struct Recipe {
    
    public private(set) var ingredients : String?
    public private(set) var title: String?
    public private(set) var thumbnailUrl: String?
    
    
    init(result: [String:String]) {
        self.ingredients = result["ingredients"]
        self.title = result["title"]
        self.thumbnailUrl = result["thumbnail"]
    }
}
