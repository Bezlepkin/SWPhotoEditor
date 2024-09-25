//
//  TextViewDelegate.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 25.09.2024.
//

import Foundation

public protocol TextViewDelegate: AnyObject {
    func textViewDidEndEditing()
    func textViewDidBeginEditing()
}
