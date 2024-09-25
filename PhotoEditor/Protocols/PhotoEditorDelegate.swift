//
//  PhotoEditorDelegate.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 25.09.2024.
//

import Foundation
import UIKit

@objc public protocol PhotoEditorDelegate {
    func doneEditing(image: UIImage)
    func canceledEditing()
}
