//
//  RecipesPresenter.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 06/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import UIKit

protocol RecipesPresenterProtocol: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,PopUpDelegate {
    func showRecipes(recipe: [Recipe])
    func getRecipes()
    func showPaginationRecipes(recipe: [Recipe])
    func recievedErrorFromFetch()
    var view: RecipesViewProtocol? { get set }
    var fetchingMore: Bool {get set}
}




class RecipesPresenter: NSObject,RecipesPresenterProtocol {

    weak var view: RecipesViewProtocol?
    var interactor: RecipesInteractorProtocol?
    let router: RecipesWireframeProtocol?
    
    var recipes = [Recipe]()
    var currentRecipes = [Recipe]()
    var fetchingMore: Bool = false
    var searchUrlString = "http://www.recipepuppy.com/api/"
    var topicSearchUrl = ""
    var fetchingOnMainScreen = true
    var page = 2
    var isTopicSearch = false
    
    init(interface: RecipesViewProtocol, interactor: RecipesInteractorProtocol?, router: RecipesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func showRecipes(recipe: [Recipe]) {
        view?.hideSpinner()
        recipes.append(contentsOf: recipe)
        view?.reloadTable()
        currentRecipes = recipes
    }
    func showPaginationRecipes(recipe: [Recipe]) {
        view?.hideSpinner()
        fetchingMore = false
        recipes.append(contentsOf: recipe)
        view?.reloadTable()
        currentRecipes = recipes
    }
    
    
    func recievedErrorFromFetch() {
        view?.showFetchError()
    }
    
    
    func getRecipes() {
        view?.showSpinner()
        interactor?.FetchRecipes(urlString: searchUrlString)
    }
    
    func getMoreRecipes() {
        interactor?.fetchPaginationRecipes(urlString: searchUrlString)
    }
    
    func loadMoreRecipes(hasTopicSearch: Bool) {
        page += 1

        if hasTopicSearch {
            // query via topic page
            searchUrlString = topicSearchUrl
            searchUrlString = "\(searchUrlString)&p=\(page)"

        } else {
            searchUrlString = "http://www.recipepuppy.com/api/"
            searchUrlString = "\(searchUrlString)?p=\(page)"
        }
        view?.showSpinner()
        getMoreRecipes()
    }
    
    
    //MARK: Custom Pop Out delegate method
    func userDidTapGoOutButton() {
    }
    
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.RecipeCell, for: indexPath) as? RecipeCell {
            
            cell.configureCell(thumbnail: recipes[indexPath.row].thumbnailUrl ?? "", title: recipes[indexPath.row].title ?? "", ingredients: recipes[indexPath.row].ingredients ?? "")
            return cell
            
        } else {
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thumbnailUrl = recipes[indexPath.row].thumbnailUrl {
            view?.showPopUpWithInfo(imgUrl: thumbnailUrl, ingredients: recipes[indexPath.row].ingredients ?? "")
        }
    }
    
    
    
    
    //MARK: ScrollView Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !fetchingMore){
            fetchingMore = true
            loadMoreRecipes(hasTopicSearch: isTopicSearch)
        }
    }
    
    //MARK: SearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keySearch = searchBar.text else {return}
        searchUrlString = "http://www.recipepuppy.com/api/?q=\(keySearch)"
        topicSearchUrl = "http://www.recipepuppy.com/api/?q=\(keySearch)"
        isTopicSearch = true
        fetchingOnMainScreen = false
        searchBar.endEditing(true)
        getRecipes()
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentRecipes = recipes
            view?.reloadTable()
            return
            
        }
        recipes = currentRecipes.filter({ (recipe) -> Bool in
            return (recipe.title?.lowercased().contains(searchText.lowercased()))!
        })
        view?.reloadTable()
    }
    
    
}


