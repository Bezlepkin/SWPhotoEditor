//
//  TypingCanvasView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import Foundation

public final class TypingCanvasView: UIView {
    
    var textColor: UIColor?
    
    var canvasImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var isEditingMode: Bool = false
    private var isReadyForDraging: Bool = false
    private var canvasImage: UIImage?
    private var currentTextView: TextView?
    private var currentX: CGFloat?
    private var currentY: CGFloat?
    
    private var endEditingTapGesture = UITapGestureRecognizer()
    
    private var textViewPreviousFrame: CGRect?
    
    public override init(frame: CGRect) {
        textColor = .black
        super.init(frame: frame)
        self.backgroundColor = .black
        setupEndEditingTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTypingInstance(image: UIImage) {
        clearPreviesTypingResult()
        
        let newTextView = createTextView()
        
        canvasImage = image
        currentTextView = newTextView
    
        layoutCanvasImageView()
        layoutTextViewInCenter()
        setupMoveGestureRecognizer()
        isEditingMode = true
    }
    
    func setColor(color: UIColor) {
        guard let currentTextView else { return }
        currentTextView.setColor(color: color)
    }
    
    func getProcessedImage() -> UIImage? {
        return self.toImage()
    }
    
    private func clearPreviesTypingResult(isSaveInstance: Bool = false) {
        if currentTextView != nil {
            currentX = nil
            currentY = nil
            
            if isSaveInstance { return }
            currentTextView?.removeFromSuperview()
            currentTextView = nil
        }
    }
    
    private func setupEndEditingTapGesture() {
        endEditingTapGesture.addTarget(self, action: #selector(textViewEndEditing))
        addGestureRecognizer(endEditingTapGesture)
    }
    
    private func setupMoveGestureRecognizer() {
        guard let currentTextView else { return }
        let textViewMoveGesture = UIPanGestureRecognizer(target: self, action: #selector(moveTextViewGesture(gestureRecognizer:)))
        currentTextView.addGestureRecognizer(textViewMoveGesture)
        currentTextView.isUserInteractionEnabled = true
    }
    
    private func createTextView() -> TextView {
        let textView = TextView()
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    
    private func layoutCanvasImageView() {
        guard let canvasImage else { return }
        canvasImageView.image = canvasImage
        addSubview(canvasImageView)

        NSLayoutConstraint.activate([
            canvasImageView.topAnchor.constraint(equalTo: topAnchor),
            canvasImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            canvasImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvasImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func layoutTextViewInCenter() {
        guard let currentTextView else { return }
        let currentTextViewFrame = currentTextView.frame
        self.textViewPreviousFrame = currentTextViewFrame
        
        currentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(currentTextView)
        NSLayoutConstraint.activate([
            currentTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func returnTextViewAnPreviousPosition() {
        guard let currentTextView, let currentX, let currentY else { return }
        
        let newHeight: CGFloat = currentTextView.frame.height
        let newWidth: CGFloat = currentTextView.frame.width
        
        let newFrame = CGRect(x: currentX, y: currentY, width: newWidth, height: newHeight)
        currentTextView.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.3) {
            currentTextView.frame = newFrame
        }
    }
}

// MARk: - OBJC methods

extension TypingCanvasView {
    @objc private func textViewEndEditing() {
        currentTextView?.endEditing(true)
    }
    
    @objc private func moveTextViewGesture(gestureRecognizer: UIPanGestureRecognizer) {
        let isEmpty: Bool = currentTextView?.isEmpty() ?? false
        
        if isEditingMode || isEmpty { return }
        guard let currentTextView else { return }
        
        if gestureRecognizer.state == .began {
            currentX = currentTextView.frame.origin.x
            currentY = currentTextView.frame.origin.y
        }
        
        if gestureRecognizer.state == .changed {
            currentTextView.translatesAutoresizingMaskIntoConstraints = true
            let translation = gestureRecognizer.translation(in: self)
            let x: CGFloat = (currentX ?? 0) - (translation.x * -1)
            let y: CGFloat = (currentY ?? 0)  - (translation.y * -1)
            let currentTextFrame = CGRect(x: x, y: y, width: currentTextView.frame.width, height: currentTextView.frame.height)

            currentTextView.frame = currentTextFrame
        }
        
        if gestureRecognizer.state == .ended {
            currentX = currentTextView.frame.origin.x
            currentY = currentTextView.frame.origin.y
        }
    }
    
}

extension TypingCanvasView: TextViewDelegate {
    // The method implements the logic at the moment we finish typing to UITextView
    public func textViewDidEndEditing() {
        isEditingMode = false
        let isEmpty: Bool = currentTextView?.isEmpty() ?? false
        
        if isEmpty {
            clearPreviesTypingResult(isSaveInstance: true)
        } else {
            returnTextViewAnPreviousPosition()
        }
    }
    // The method implements the logic at the moment we start typing to UITextView
    public func textViewDidBeginEditing() {
        isEditingMode = true
        layoutTextViewInCenter()
    }
}
