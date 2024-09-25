//
//  PhotoEditor+Controls.swift
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
        setTypingCanvasViewVisibility(visibility: false)
        hideToolbar(hide: false)
        
        handleCancelAction()
        colorsCollectionViewDelegate.resetColor(collectionView: contentView.colorsCollectionView)
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
        contentView.drawingView.color = colors[0]
    }
    
    @objc func textButtonTapped() {
        activeMode = ModeType.typing
        setTypingCanvasViewVisibility(visibility: true)
        setActionsToolbarVisibility(visibility: true)
        setColorPickerVisibility(visibility: true)
        hideToolbar(hide: true)
        
        contentView.typingCanvasView.createTypingInstance(image: currentImage)
        colorsCollectionViewDelegate.setUnselected(collectionView: contentView.colorsCollectionView)
        isTyping = true
    }
    
    @objc func applyButtonTapped() {
        view.endEditing(true)
        setActionsToolbarVisibility(visibility: false)
        setColorPickerVisibility(visibility: false)
        
        contentView.drawingView.isHidden = true
        setTypingCanvasViewVisibility(visibility: false)
        hideToolbar(hide: false)

        handleApplyAction()
        colorsCollectionViewDelegate.resetColor(collectionView: contentView.colorsCollectionView)
    }
    
    // MARK: Bottom Toolbar
    
    @objc func continueButtonPressed() {
        // let img =  contentView.canvasView.toImage()
        photoEditorDelegate?.doneEditing(image: currentImage)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MAKR: helper methods
    /*
    @objc func image(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: "Image Saved", message: "Image successfully saved to Photos library", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    */
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
        case .typing:
            let image: UIImage? = contentView.typingCanvasView.getProcessedImage()
            if let image {
                // let mergedImage: UIImage = currentImage.mergeWith(topImage: image)
                setImage(image: image)
            }
            break
        case .none: break
        }
    }
}
