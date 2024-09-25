//
//  PhotoEditorDelegate.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 25.09.2024.
//

import Foundation
import UIKit

public protocol PhotoEditorDelegate: AnyObject {
    func doneEditing(image: UIImage)
    func canceledEditing()
}
