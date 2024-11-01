//
//  TextViewDelegate.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import Foundation

public final class TextView: UIView {
    var textColor: UIColor?;
    weak var delegate: TextViewDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "Helvetica", size: 18)
        textView.textColor = textColor
        textView.tintColor = .white
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.autocorrectionType = .no
        textView.textContainerInset = .zero
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        textView.delegate = self
        
        return textView
    }()
    
    lazy private var placeholderLabel: UILabel = {
        let bundle = Bundle(for: type(of: self))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("ENTER_TEXT", tableName: nil, bundle: bundle, value: "", comment: "")
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont(name: "Helvetica", size: 18)
        
        return label
    }()
    
    public override init(frame: CGRect) {
        textColor = .black
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        layoutTextView()
        layoutPlaceholderLabel()
        textView.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(color: UIColor) {
        textView.textColor = color
    }
    
    func isEmpty() -> Bool {
        return textView.text.isEmpty
    }
    
    private func placeholderVisibility(visibility: Bool) {
        placeholderLabel.isHidden = !visibility
    }
    
    private func setupUI() {
        backgroundColor = .none
        textView.layer.cornerRadius = 4
    }
    
    private func layoutTextView() {
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 4),
            textView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutPlaceholderLabel() {
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension TextView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        if (updatedText.count > 0) {
            placeholderVisibility(visibility: false)
            textView.backgroundColor = .white
        } else {
            placeholderVisibility(visibility: true)
            textView.backgroundColor = .none
        }
        
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textViewDidEndEditing()
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.textViewDidBeginEditing()
    }
}
