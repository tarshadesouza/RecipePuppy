//
//  CustomPopUp.swift
//  STSocialMedia
//
//  Created by Tarsha De Souza on 11/07/2019.
//  Copyright © 2019 Hassan, Waseem (Isban). All rights reserved.
// all outlets to custom pop up class

import UIKit

public protocol PopUpDelegate {
    func userDidTapGoOutButton()
}

class CustomPopUp: UIView {
    
    public var delegate : PopUpDelegate?
    static let instance = CustomPopUp()
    //MARK: IBoutlets
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func commonInit() {
        viewContainer.layer.cornerRadius = 5
        viewContainer.clipsToBounds = true
        
        // config outlets
        ingredientsLabel.sizeToFit()
        
    }
    
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    
    
    
    
}



