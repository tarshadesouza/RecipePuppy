//
//  RecipesViewController.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 06/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import UIKit


protocol RecipesViewProtocol: class {
    var presenter: RecipesPresenterProtocol? { get set }
    func reloadTable()
    func showPopUpWithInfo(imgUrl: String?, ingredients: String)
    func showFetchError()
    func showSpinner()
    func hideSpinner()
}

class RecipesViewController: UIViewController,RecipesViewProtocol {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var presenter: RecipesPresenterProtocol?
    
    override func viewDidLoad() {
        presenter?.getRecipes()
        configureUI()
    }
    

    func configureUI() {
        tableView.delegate = presenter
        tableView.dataSource = presenter
        searchBar.delegate = presenter
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        registerCells()
        
        //handling keyboard
        self.hideKeyboardWhenTappedAround()

    }
    
    func showSpinner() {
        spinner.isHidden = false
    }
    
    func hideSpinner() {
        spinner.isHidden = true
    }
    
    func registerCells() {
        let bundle = Bundle(for: RecipesViewController.self)
        
        let recipeCellNib = UINib(nibName: "RecipeCell", bundle: bundle)
        tableView.register(recipeCellNib, forCellReuseIdentifier: RecipeCell.nibString())
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    class func initFromStoryboard() -> RecipesViewController {
        if let viewController = UIStoryboard(name: StoryboardID.RecipesViewController, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.RecipesViewController) as? RecipesViewController {
            return viewController
        } else {
            assert(false, "This should never happen")
            return RecipesViewController()
        }
    }
    
    
    func showPopUpWithInfo(imgUrl: String?, ingredients: String) {
        
        let bundle = Bundle(for: type(of: self))
        if let popUp = bundle.loadNibNamed(CustomViews.CustomPopUp, owner: self, options: nil)?.first as? CustomPopUp{
            
            // set up
            if let thumbnail = imgUrl {
                let img = popUp.thumbnailImage.loadImage(imageObject: thumbnail)
                popUp.thumbnailImage.image = img
                popUp.ingredientsLabel.text = ingredients
            }
            
            view.addSubview(popUp)
            view.bringSubviewToFront(popUp)
            
            popUp.translatesAutoresizingMaskIntoConstraints = false
            popUp.translatesAutoresizingMaskIntoConstraints = false
            popUp.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            popUp.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            popUp.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            popUp.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            popUp.delegate = presenter
            
        }
    }
    
    func showFetchError() {
        let alert = UIAlertController(title: "Woops", message: "I cant find what your looking for try again..🤷‍♀", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}



