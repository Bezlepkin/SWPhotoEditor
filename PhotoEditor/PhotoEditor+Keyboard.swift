//
//  PhotoEditorView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 23.09.2024.
//

import Foundation
import UIKit

extension PhotoEditorViewController {
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        // moveViewWithKeyboard(notification: notification, constraint: contentView.colorPickerViewBottomConstraint, keyboardWillShow: true)
        handleForKeyboardWillShow(notification: notification, keyboardWillShow: true)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if isTyping {
            //contentView.actionsToolbar.isHidden = false
            //contentView.colorPickerView.isHidden = false
            //hideToolbar(hide: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //isTyping = false
        //contentView.actionsToolbar.isHidden = true
        //hideToolbar(hide: false)
        handleForKeyboardWillShow(notification: notification, keyboardWillShow: false)
        // moveViewWithKeyboard(notification: notification, constraint: contentView.colorPickerViewBottomConstraint, keyboardWillShow: false)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                contentView.colorPickerViewBottomConstraint?.constant = 0.0
            } else {
                contentView.colorPickerViewBottomConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    private func handleForKeyboardWillShow(notification: NSNotification, keyboardWillShow: Bool) {
        // Keyboard size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        // Keyboard animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        // Keyboard animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        if keyboardWillShow {
            setActionsToolbarVisibility(visibility: false)
            moveCanvasViewToTop(keyboardHeight: keyboardHeight)
            moveColorViewToTop(keyboardHeight: keyboardHeight)
        } else {
            setActionsToolbarVisibility(visibility: true)
            moveCanvasViewToBottom(keyboardHeight: keyboardHeight)
            moveColorViewToBottom(keyboardHeight: keyboardHeight)
        }
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
    
    private func moveCanvasViewToTop(keyboardHeight: CGFloat) {
        let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
        let bottomConstant: CGFloat = safeAreaExists ? 0 : 16
        contentView.typingCanvasView.canvasImageView.alpha = 0.5
        contentView.canvasViewBottomConstraint.constant = (keyboardHeight + bottomConstant) * -1
    }
    
    private func moveCanvasViewToBottom(keyboardHeight: CGFloat) {
        contentView.typingCanvasView.canvasImageView.alpha = 1
        contentView.canvasViewBottomConstraint.constant = 0
    }
    
    private func moveColorViewToTop(keyboardHeight: CGFloat) {
        let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
        let bottomConstant: CGFloat = safeAreaExists ? 0 : 16
        contentView.colorPickerViewBottomConstraint.constant = (keyboardHeight + bottomConstant) * -1
    }
    
    
    private func moveColorViewToBottom(keyboardHeight: CGFloat) {
        let safeAreaInsetsBottom = self.view?.window?.safeAreaInsets.bottom ?? CGFloat(0)
        contentView.colorPickerViewBottomConstraint.constant = safeAreaInsetsBottom * -1
    }
}
