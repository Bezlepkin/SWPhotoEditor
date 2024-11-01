//
//  PhotoEditorView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 12.09.2024.
//

import Foundation

public final class PhotoEditorView: UIView {
    var canvasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    var canvasViewBottomConstraint: NSLayoutConstraint!
    
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
    
    var drawingView: DrawingCanvasView = {
        let drawingView = DrawingCanvasView()
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        drawingView.contentMode = .scaleAspectFit
        drawingView.isHidden = true
        return drawingView
    }()
    
    var typingCanvasView: TypingCanvasView = {
        let typingCanvasView = TypingCanvasView()
        typingCanvasView.translatesAutoresizingMaskIntoConstraints = false
        typingCanvasView.contentMode = .scaleAspectFit
        typingCanvasView.isHidden = true
        return typingCanvasView
    }()
    
    var typingCanvasBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Actions Toolbar
    
    var actionsToolbar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    private var actionsToolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Top Toolbar
    
    var topToolbar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    
    private var topToolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
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
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Buttons
    
    var cropButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorCropIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var drawButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorDrawIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorTextIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var closeButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorCloseIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cancelButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorArrowLeftIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var applyButton: ImageButton = {
        let button = ImageButton(imageName: "PhotoEditorCheckIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
        return button
    }()
    
    lazy var continueButton: HiglihtedButton = {
        let bundle = Bundle(for: type(of: self))
        let buttonTitle: String = NSLocalizedString("SAVE", tableName: nil, bundle: bundle, value: "", comment: "")
        
        let button = HiglihtedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .medium)
        button.backgroundColor = UIColor(red: 1, green: 0.72, blue: 0.01, alpha: 1)
        button.layer.cornerRadius = 18
        return button
    }()

    // MARK: - End Buttons
    
    private var colors: [UIColor]!
    
    // MARK: - Initialize
    
    required init(frame: CGRect, colors: [UIColor]) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.colors = colors
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        layoutCanvasView()
        layoutImageView()
        layoutCanvasImageView()
        layoutDrawingView()
        layoutTypingCanvasView()
        layoutTopToolbar()
        layoutActionsToolbar()
        layoutTopToolBarStackView()
        layoutActionsToolBarStackView()
        layoutCloseButton()
        layoutCancelButton()
        layoutBottomToolbar()
        layoutContinueButton()
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
            canvasView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            canvasView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        canvasViewBottomConstraint = canvasView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        canvasViewBottomConstraint.isActive = true
    }
    
    private func layoutImageView() {
        canvasView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
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
    
    private func layoutDrawingView() {
        canvasView.addSubview(drawingView)
        NSLayoutConstraint.activate([
            drawingView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            drawingView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            drawingView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func layoutTypingCanvasView() {
        canvasView.addSubview(typingCanvasView)
        NSLayoutConstraint.activate([
            typingCanvasView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            typingCanvasView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            typingCanvasView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            typingCanvasView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
        
        typingCanvasBottomConstraint = typingCanvasView.heightAnchor.constraint(equalToConstant: 667)
        typingCanvasBottomConstraint.isActive = true
    }
    
    private func layoutTopToolbar() {
        self.addSubview(topToolbar)
        
        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topToolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topToolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topToolbar.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func layoutActionsToolbar() {
        self.addSubview(actionsToolbar)

        NSLayoutConstraint.activate([
            actionsToolbar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            actionsToolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            actionsToolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            actionsToolbar.heightAnchor.constraint(equalToConstant: 32)
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
            topToolBarStackView.trailingAnchor.constraint(equalTo: topToolbar.trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutActionsToolBarStackView() {
        actionsToolBarStackView.addArrangedSubview(applyButton)
        actionsToolbar.addSubview(actionsToolBarStackView)
        
        NSLayoutConstraint.activate([
            actionsToolBarStackView.topAnchor.constraint(equalTo: actionsToolbar.topAnchor),
            actionsToolBarStackView.bottomAnchor.constraint(equalTo: actionsToolbar.bottomAnchor),
            actionsToolBarStackView.trailingAnchor.constraint(equalTo: actionsToolbar.trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutCloseButton() {
        topToolbar.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: topToolbar.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: topToolbar.leadingAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: ImageButton.BUTTON_BORDER),
            closeButton.widthAnchor.constraint(equalToConstant: ImageButton.BUTTON_BORDER)
        ])
    }
    
    private func layoutCancelButton() {
        actionsToolbar.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: actionsToolbar.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: actionsToolbar.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: ImageButton.BUTTON_BORDER),
            cancelButton.widthAnchor.constraint(equalToConstant: ImageButton.BUTTON_BORDER)
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
    
    private func layoutContinueButton() {
        bottomToolbar.addSubview(continueButton)
        NSLayoutConstraint.activate([
            continueButton.trailingAnchor.constraint(equalTo: bottomToolbar.trailingAnchor, constant: -12),
            continueButton.bottomAnchor.constraint(equalTo: bottomToolbar.bottomAnchor, constant: -12),
            continueButton.heightAnchor.constraint(equalToConstant: 36)
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
        ])
        
        colorPickerViewBottomConstraint = colorPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: safeAreaInsetsBottom * -1)
        colorPickerViewBottomConstraint.isActive = true
    }
    
    private func layoutColorsCollectionView() {
        colorPickerView.addSubview(colorsCollectionView)
        let collectionViewHeight = calculateColorCellSize().height
        NSLayoutConstraint.activate([
            colorsCollectionView.topAnchor.constraint(equalTo: colorPickerView.topAnchor),
            colorsCollectionView.leadingAnchor.constraint(equalTo: colorPickerView.leadingAnchor, constant: 0),
            colorsCollectionView.trailingAnchor.constraint(equalTo: colorPickerView.trailingAnchor, constant: 0),
            colorsCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }
    
    private func calculateColorCellSize() -> CGSize {
        let collectionWidth: CGFloat = self.frame.width - (16 * 2)
        let spacings = CGFloat(colors.count - 1) * ColorsCollectionViewDelegate.HORIZONTAL_SPACING
        let cellBorder = (collectionWidth - spacings) / CGFloat(colors.count)
        return CGSize(width: cellBorder, height: cellBorder)
    }
}
