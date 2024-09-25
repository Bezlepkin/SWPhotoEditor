//
//  UIView+Image.swift
//  Photo Editor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import UIKit

extension UIView {
    /**
     Convert UIView to UIImage
     */
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        /*
        guard let imageData = image?.pngData() else {
            return nil
        }
        
        return UIImage.init(data: imageData)
         */
        return image
    }
}
