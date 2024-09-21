//
//  TextView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import Foundation

public final class TextView: UIView {
    var textColor: UIColor?;
    
    private var textViewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFit
        container.backgroundColor = .green
        
        return container
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "Helvetica", size: 24)
        textView.textColor = textColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowRadius = 1.0
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.autocorrectionType = .no
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    public override init(frame: CGRect) {
        textColor = .black
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layoutTextViewContainer()
        layoutTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutTextViewContainer() {
        addSubview(textViewContainer)
        
        NSLayoutConstraint.activate([
            textViewContainer.topAnchor.constraint(equalTo: topAnchor),
            textViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            textViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            textViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func layoutTextView() {
        textViewContainer.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 6),
            textView.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor, constant: 6),
            textView.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor, constant: -6),
            textView.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: -6)
        ])
    }
}
