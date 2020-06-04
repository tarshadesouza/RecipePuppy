//
//  UIImageExtension.swift
//  RecipePuppyTest
//
//  Created by Tarsha De Souza on 07/08/2019.
//  Copyright © 2019 Tarsha De Souza. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func loadImage(imageObject: String)-> UIImage {

        // declare image location
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageObject).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        //look in cache
        if let cachedImage = CacheService.imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            return cachedImage
        }
        
        //download img
        if let url = URL(string: imageObject) {
            let data = NSData(contentsOf: url)
            let newImage = UIImage(data: data! as Data)
            CacheService.imageCache.setObject(newImage!, forKey: imageUrl.absoluteString as NSString)
            try? newImage!.pngData()?.write(to: imageUrl)
            return newImage!
            
        } else {
            return UIImage()
        }
        
    }
    
    
}

