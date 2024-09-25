//
//  Color.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 25.09.2024.
//

import UIKit

enum Color {
    case white
    case black
    case red
    case green
    case blue
    case yellow
    case pink
    case orange
    case brown
    
    var color: UIColor {
        switch self {
            case .white:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .black:
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            case .red:
                return UIColor(red: 0.86, green: 0.15, blue: 0.15, alpha: 1)
            case .green:
                return UIColor(red: 0.3, green: 0.69, blue: 0.31, alpha: 1)
            case .blue:
                return UIColor(red: 0.13, green: 0.59, blue: 0.95, alpha: 1)
            case .yellow:
                return UIColor(red: 1, green: 0.92, blue: 0.23, alpha: 1)
            case .pink:
                return UIColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1)
            case .orange:
                return UIColor(red: 1, green: 0.6, blue: 0, alpha: 1)
            case .brown:
                return UIColor(red: 0.47, green: 0.33, blue: 0.28, alpha: 1)
        }
    }
}
