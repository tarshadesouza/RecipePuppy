//
//  RecipesRouter.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 06/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import UIKit

protocol RecipesWireframeProtocol: class {
}

class RecipesRouter: RecipesWireframeProtocol{
    
    
    weak var viewController: UIViewController?
    
    static func createModule() -> RecipesViewController {
        let view = RecipesViewController.initFromStoryboard()
        let interactor = RecipesInteractor()
        let router = RecipesRouter()
        let presenter = RecipesPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
  
    
}
