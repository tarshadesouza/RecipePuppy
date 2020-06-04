//
//  RecipesInteractor.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 06/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol RecipesInteractorProtocol: class {
    var presenter: RecipesPresenterProtocol? { get set }
    func FetchRecipes(urlString: String)
    func fetchPaginationRecipes(urlString: String)
}



class RecipesInteractor: RecipesInteractorProtocol {
    
    var presenter: RecipesPresenterProtocol?
    
    func FetchRecipes(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value) :
                var recipes = [Recipe]()
                
                if let jsonDict = value as? [String:AnyObject] {
                    if let results = jsonDict["results"] as? Array<Dictionary<String,String>> {
                        for x in results {
                            let recipe = Recipe(result: x)
                            recipes.append(recipe)
                        }
                        self.presenter?.showRecipes(recipe: recipes)
                    }
                }
                
            case .failure(let error):
                self.presenter?.recievedErrorFromFetch()
            }
        }
        
    }
    
    //TODO: if search returns zero results then need to show no results returned. with cool animation
    
    func fetchPaginationRecipes(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value) :
                var recipes = [Recipe]()
                
                if let jsonDict = value as? [String:AnyObject] {
                    if let results = jsonDict["results"] as? Array<Dictionary<String,String>> {
                        for x in results {
                            let recipe = Recipe(result: x)
                            recipes.append(recipe)
                        }
                    }
                    
                    self.presenter?.showPaginationRecipes(recipe: recipes)
                }
                
            case .failure(let error):
                self.presenter?.recievedErrorFromFetch()
            }
        }
    }
    
    
}
