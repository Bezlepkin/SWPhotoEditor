//
//  PhotoEditorView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 12.09.2024.
//

import Foundation
import UIKit

public enum ModeType {
    case cropping
    case drawing
    case typing
}

extension PhotoEditorViewController {
    
    // MARK: - Top Toolbar
    
    @objc func closeButtonWasTapped() {
        photoEditorDelegate?.canceledEditing()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonWasTapped() {
        view.endEditing(true)
        setActionsToolbarVisibility(visibility: false)
        contentView.colorPickerView.isHidden = true
        contentView.drawingView.isHidden = true
        hideToolbar(hide: false)
        
        handleCancelAction()
    }
    
    @objc func cropButtonTapped() {
        activeMode = ModeType.cropping
        let controller = CropViewController()
        controller.delegate = self
        controller.image = currentImage
        controller.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: controller)
        navController.view.backgroundColor = .black
        navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(navController, animated: true, completion: nil)
    }
    
    @objc func drawButtonTapped() {
        activeMode = ModeType.drawing
        contentView.drawingView.isHidden = false
        contentView.canvasImageView.isUserInteractionEnabled = false
        
        setActionsToolbarVisibility(visibility: true)
        setColorPickerVisibility(visibility: true)
        
        hideToolbar(hide: true)
    }
    
    @objc func textButtonTapped() {
        activeMode = ModeType.typing
        setActionsToolbarVisibility(visibility: true)
        setColorPickerVisibility(visibility: true)
        hideToolbar(hide: true)
        
        isTyping = true
        /*
        let textView = UITextView(
            frame: CGRect(
                x: 0,
                y:  contentView.canvasImageView.center.y,
                width: UIScreen.main.bounds.width,
                height: 30
            )
        )
        
        textView.textAlignment = .center
        textView.font = UIFont(name: "Helvetica", size: 30)
        textView.textColor = textColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowRadius = 1.0
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.autocorrectionType = .no
        textView.isScrollEnabled = false
        textView.delegate = self
        contentView.canvasImageView.addSubview(textView)
        // addGestures(view: textView)
        textView.becomeFirstResponder()
         */
    }
    
    @objc func applyButtonTapped() {
        view.endEditing(true)
        setActionsToolbarVisibility(visibility: false)
        setColorPickerVisibility(visibility: false)
        
        contentView.drawingView.isHidden = true
        hideToolbar(hide: false)

        handleApplyAction()
    }
    
    //MARK: Bottom Toolbar
    
    @objc func continueButtonPressed() {
        let img =  contentView.canvasView.toImage()
        photoEditorDelegate?.doneEditing(image: img)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MAKR: helper methods
    
    @objc func image(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: "Image Saved", message: "Image successfully saved to Photos library", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleCancelAction() {
        switch activeMode {
        case .cropping: break
        case .drawing:
            // contentView.drawingView.getProcessedImage()
            let image: UIImage? = contentView.drawingView.getProcessedImage()
            if (image != nil) {
                contentView.drawingView.clearDrawingResult()
            }

            break
        case .typing: break
        case .none: break
        }
    }
    
    private func handleApplyAction() {
        switch activeMode {
        case .cropping: break
        case .drawing:
            let image: UIImage? = contentView.drawingView.getProcessedImage()
            if let image {
                let mergedImage: UIImage = currentImage.mergeWith(topImage: image)
                setImage(image: mergedImage)
            }
            break
        case .typing: break
        case .none: break
        }
    }
}
