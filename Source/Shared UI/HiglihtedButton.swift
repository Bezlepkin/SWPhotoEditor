//
//  HiglihtedButton.swift
//  TestSmarteks
//
//  Created by Yauheni Zhurauski on 27.06.24.
//

import UIKit

public final class HiglihtedButton: UIButton {
    
    public override var isHighlighted: Bool {
        didSet {
            let alpha = isHighlighted ? 0.7 : 1
            self.alpha = alpha
        }
    }
    
}
