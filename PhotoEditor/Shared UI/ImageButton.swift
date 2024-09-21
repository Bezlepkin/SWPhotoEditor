//
//  ImageButton.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 17.09.2024.
//

import UIKit

public final class ImageButton: UIButton {
    static let BUTTON_BORDER: CGFloat = 32
    
    private var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    public override var isHighlighted: Bool {
        didSet {
            let alpha = isHighlighted ? 0.7 : 1
            self.alpha = alpha
        }
    }
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        setupButton()
        setupImage(imageName: imageName)
        layoutCustomImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        layer.cornerRadius = Self.BUTTON_BORDER / 2
        backgroundColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
    }
    
    private func setupImage(imageName: String) {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        // let image2 = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        
        customImageView.image = image
    }
    
    private func layoutCustomImageView() {
        addSubview(customImageView)
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            customImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            customImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
}
