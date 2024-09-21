//
//  TypingView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import Foundation

public final class TypingView: UIView {
    
    var textColor: UIColor?
    
    private var canvas: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect) {
        textColor = .black
        
        super.init(frame: frame)
        
        layoutCanvas()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutCanvas() {
        addSubview(canvas)
        
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: centerYAnchor),
            canvas.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            canvas.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
}
