//
//  ViewController.swift
//  PhotoEditorDemo
//
//  Created by Igor Bezlepkin on 29.06.2024.
//

import UIKit
import PhotosUI
import PhotoEditor

class ViewController: UIViewController {
    
    private lazy var pickImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Take photo", for: .normal)
        button.addTarget(self, action: #selector(pickImageWasPressed), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutPickImageButton()
    }
    
    private func presentPhotoEditor(with image: UIImage) {
        let photoEditor = PhotoEditorViewController()
        
        photoEditor.image = image
        photoEditor.colors = [
            Color.white.color,
            Color.black.color,
            Color.red.color,
            Color.green.color,
            Color.blue.color,
            Color.yellow.color,
            Color.pink.color,
            Color.orange.color,
            Color.brown.color
        ]
        photoEditor.modalPresentationStyle = .fullScreen
        
        self.present(photoEditor, animated: true, completion: nil)
    }
    
    private func layoutPickImageButton() {
        view.addSubview(pickImageButton)
        NSLayoutConstraint.activate([
            pickImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickImageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickImageButton.heightAnchor.constraint(equalToConstant: 60),
            pickImageButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

// MARK: - OBJC Methods

extension ViewController {
    @objc
    private func pickImageWasPressed() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async { [weak self] in
                        self?.presentPhotoEditor(with: image)
                    }
                }
            }
        }
    }
}
