//
//  PhotoEditorView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 12.09.2024.
//

import Foundation

public final class PhotoEditorView: UIView {
    public var colors  : [UIColor] = []
    
    var canvasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageViewHeightConstraint: NSLayoutConstraint!
    
    var canvasImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var topGradient: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    var topToolbar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    private var topToolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var bottomGradient: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    var bottomToolbar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    private var bottomToolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var doneButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.isHidden = true
        button.titleLabel?.font = UIFont(name: "System Semibold ", size: 16)
        return button
    }()
    
    var deleteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        view.isHidden = true
        return view
    }()
    var deleteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "icomoon", size: 30)
        label.textColor = .white
        label.text = ""
        return label
    }()
    var colorPickerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    var colorPickerViewBottomConstraint: NSLayoutConstraint!
    
    var colorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = UIColor.black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Buttons
    
    var cropButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var drawButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var textButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var closeButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var saveButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var shareButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var clearButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 25)
        return button
    }()
    
    var continueButton: HiglihtedButton = {
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "icomoon", size: 50)
        return button
    }()
    
    // MARK: - End Buttons
    
    
    
    // MARK: - Initialize
    
    required init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .black
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        layoutCanvasView()
        layoutImageView()
        layoutCanvasImageView()
        layoutTopGradient()
        layoutTopToolbar()
        layoutTopToolBarStackView()
        layoutCloseButton()
        layoutBottomGradient()
        layoutBottomToolbar()
        layoutBottomToolBarStackView()
        layoutContinueButton()
        layoutDoneButton()
        layoutDeleteView()
        layoutDeleteLabel()
        layoutColorPickerView()
        layoutColorsCollectionView()
    }
    
    private func layoutCanvasView() {
        self.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            canvasView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func layoutImageView() {
        canvasView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: canvasView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 667)
        imageViewHeightConstraint.isActive = true
    }
    
    private func layoutCanvasImageView() {
        canvasView.addSubview(canvasImageView)
        NSLayoutConstraint.activate([
            canvasImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            canvasImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            canvasImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            canvasImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func layoutTopGradient() {
        self.addSubview(topGradient)
        NSLayoutConstraint.activate([
            topGradient.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topGradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topGradient.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func layoutTopToolbar() {
        self.addSubview(topToolbar)
        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topToolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topToolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topToolbar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func layoutTopToolBarStackView() {
        topToolBarStackView.addArrangedSubview(cropButton)
        topToolBarStackView.addArrangedSubview(drawButton)
        topToolBarStackView.addArrangedSubview(textButton)
        
        topToolbar.addSubview(topToolBarStackView)
        NSLayoutConstraint.activate([
            topToolBarStackView.topAnchor.constraint(equalTo: topToolbar.topAnchor),
            topToolBarStackView.bottomAnchor.constraint(equalTo: topToolbar.bottomAnchor),
            topToolBarStackView.trailingAnchor.constraint(equalTo: topToolbar.trailingAnchor, constant: -12)
        ])
    }
    
    private func layoutCloseButton() {
        topToolbar.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: topToolbar.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: topToolbar.leadingAnchor, constant: 12)
        ])
    }
    
    private func layoutBottomGradient() {
        self.addSubview(bottomGradient)
        NSLayoutConstraint.activate([
            bottomGradient.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            bottomGradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomGradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomGradient.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func layoutBottomToolbar() {
        self.addSubview(bottomToolbar)
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomToolbar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            bottomToolbar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func layoutBottomToolBarStackView() {
        bottomToolbar.addSubview(bottomToolBarStackView)
        
        bottomToolBarStackView.addArrangedSubview(saveButton)
        bottomToolBarStackView.addArrangedSubview(shareButton)
        bottomToolBarStackView.addArrangedSubview(clearButton)
        
        NSLayoutConstraint.activate([
            bottomToolBarStackView.topAnchor.constraint(equalTo: bottomToolbar.topAnchor),
            bottomToolBarStackView.leadingAnchor.constraint(equalTo: bottomToolbar.leadingAnchor, constant: 12),
            bottomToolBarStackView.bottomAnchor.constraint(equalTo: bottomToolbar.bottomAnchor, constant: -8)
        ])
    }
    
    private func layoutContinueButton() {
        bottomToolbar.addSubview(continueButton)
        NSLayoutConstraint.activate([
            continueButton.trailingAnchor.constraint(equalTo: bottomToolbar.trailingAnchor, constant: -12),
            continueButton.bottomAnchor.constraint(equalTo: bottomToolbar.bottomAnchor, constant: -12)
        ])
    }
    
    private func layoutDoneButton() {
        self.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -12)
        ])
    }
    
    private func layoutDeleteView() {
        self.addSubview(deleteView)
        NSLayoutConstraint.activate([
            deleteView.heightAnchor.constraint(equalToConstant: 50),
            deleteView.widthAnchor.constraint(equalToConstant: 50),
            deleteView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func layoutDeleteLabel() {
        deleteView.addSubview(deleteLabel)
        NSLayoutConstraint.activate([
            deleteLabel.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
            deleteLabel.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor)
        ])
    }
    
    private func layoutColorPickerView() {
        let window = UIApplication.shared.keyWindow
        let safeAreaInsetsBottom = window?.safeAreaInsets.bottom ?? CGFloat(0)
        
        self.addSubview(colorPickerView)
        NSLayoutConstraint.activate([
            colorPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorPickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorPickerView.heightAnchor.constraint(equalToConstant: 40),
            colorPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: safeAreaInsetsBottom * -1)
        ])
        
        colorPickerViewBottomConstraint = colorPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        colorPickerViewBottomConstraint.isActive = true
    }
    
    private func layoutColorsCollectionView() {
        colorPickerView.addSubview(colorsCollectionView)
        let collectionViewHeight = calculateColorCellSize().height
        
        NSLayoutConstraint.activate([
            colorsCollectionView.topAnchor.constraint(equalTo: colorPickerView.topAnchor),
            colorsCollectionView.leadingAnchor.constraint(equalTo: colorPickerView.leadingAnchor, constant: 16),
            colorsCollectionView.trailingAnchor.constraint(equalTo: colorPickerView.trailingAnchor, constant: -16),
            // colorsCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }
    
    private func calculateColorCellSize() -> CGSize {
        let collectionWidth: CGFloat = self.frame.width - (16 * 2)
        let spacings = CGFloat(colors.count - 1) * ColorsCollectionViewDelegate.HORIZONTAL_SPACING
        let cellBorder = (collectionWidth - spacings) / CGFloat(colors.count)
        return CGSize(width: cellBorder, height: cellBorder)
    }
}
