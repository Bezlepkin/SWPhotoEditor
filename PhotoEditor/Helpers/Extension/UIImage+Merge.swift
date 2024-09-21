//
//  UIImage+Merge.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 19.09.2024.
//

import UIKit

extension UIImage {
    /*
     The method implements merging of two images
     */
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self
        
        UIGraphicsBeginImageContext(size)
        
        
        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)
        
        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}
