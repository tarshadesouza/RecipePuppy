//
//  UIViewControllerExtension.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 09/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import UIKit

    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    }

