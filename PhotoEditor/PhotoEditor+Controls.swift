//
//  PhotoEditor+Controls.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

// MARK: - Control
public enum Control {
    case crop
    case draw
    case save
    case share
    case clear
}

extension PhotoEditorViewController {

    // MARK: - Top Toolbar
    
    @objc func closeButtonWasTapped() {
        photoEditorDelegate?.canceledEditing()
        self.dismiss(animated: true, completion: nil)
    }

    @objc func cropButtonTapped() {
        let controller = CropViewController()
        controller.delegate = self
        controller.image = image
        controller.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: controller)
        navController.view.backgroundColor = .black
        navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(navController, animated: true, completion: nil)
    }
    
    @objc func drawButtonTapped() {
        isDrawing = true
        contentView.canvasImageView.isUserInteractionEnabled = false
        contentView.doneButton.isHidden = false
        contentView.colorPickerView.isHidden = false
        hideToolbar(hide: true)
    }
    
    @objc func textButtonTapped() {
        isTyping = true
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
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
        contentView.doneButton.isHidden = true
        contentView.colorPickerView.isHidden = true
        contentView.canvasImageView.isUserInteractionEnabled = true
        hideToolbar(hide: false)
        isDrawing = false
    }
    
    //MARK: Bottom Toolbar
    
    @objc func saveButtonTapped() {
        UIImageWriteToSavedPhotosAlbum( contentView.canvasView.toImage(),self, #selector(PhotoEditorViewController.image(_:withPotentialError:contextInfo:)), nil)
    }
    
    @objc func shareButtonTapped() {
        let activity = UIActivityViewController(activityItems: [ contentView.canvasView.toImage()], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
    
    @objc func clearButtonTapped() {
        //clear drawing
        contentView.canvasImageView.image = nil
        //clear stickers and textviews
        for subview in  contentView.canvasImageView.subviews {
            subview.removeFromSuperview()
        }
    }
    
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
    
    func hideControls() {
        for control in hiddenControls {
            switch control {

            case .clear:
                contentView.clearButton.isHidden = true
            case .crop:
                contentView.cropButton.isHidden = true
            case .draw:
                contentView.drawButton.isHidden = true
            case .save:
                contentView.saveButton.isHidden = true
            case .share:
                contentView.shareButton.isHidden = true
            }
        }
    }
    
}
