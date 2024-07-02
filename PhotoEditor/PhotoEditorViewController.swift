import UIKit

public final class PhotoEditorViewController: UIViewController {
    
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
    
    
    public var image: UIImage?
    public var colors  : [UIColor] = [] // array of Colors that will show while drawing or typing
    public var photoEditorDelegate: PhotoEditorDelegate?
    lazy var colorsCollectionViewDelegate: ColorsCollectionViewDelegate = ColorsCollectionViewDelegate(displayedView: view)
    public var hiddenControls : [control] = []  // list of controls to be hidden
    
    var drawColor: UIColor = UIColor.black
    var textColor: UIColor = UIColor.white
    var isDrawing: Bool = false
    var lastPoint: CGPoint!
    var swiped = false
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    var lastTextViewFont:UIFont?
    var activeTextView: UITextView?
    var imageViewToPan: UIImageView?
    var isTyping: Bool = false

    //Register Custom font before we load XIB
    public override func loadView() {
        registerFont()
        super.loadView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        layoutElements()
        setupActions()
        
        self.setImageView(image: image!)
        
        deleteView.layer.cornerRadius = deleteView.bounds.height / 2
        deleteView.layer.borderWidth = 2.0
        deleteView.layer.borderColor = UIColor.white.cgColor
        deleteView.clipsToBounds = true
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .bottom
        edgePan.delegate = self
        self.view.addGestureRecognizer(edgePan)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        configureCollectionView()
        hideControls()
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 28, height: 28)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        colorsCollectionView.collectionViewLayout = layout
        colorsCollectionViewDelegate.colorDelegate = self
        
        if !colors.isEmpty {
            colorsCollectionViewDelegate.colors = colors
        }
        
        colorsCollectionView.delegate = colorsCollectionViewDelegate
        colorsCollectionView.dataSource = colorsCollectionViewDelegate
        colorsCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.id)
    }
    
    func setImageView(image: UIImage) {
        imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        imageViewHeightConstraint.constant = (size?.height)!
    }
    
    func hideToolbar(hide: Bool) {
        topToolbar.isHidden = hide
        topGradient.isHidden = hide
        bottomToolbar.isHidden = hide
        bottomGradient.isHidden = hide
    }
    
    func calculateColorCellSize() -> CGSize {
        let collectionWidth: CGFloat = view.frame.width - (16 * 2)
        let spacings = CGFloat(colors.count - 1) * ColorsCollectionViewDelegate.HORIZONTAL_SPACING
        let cellBorder = (collectionWidth - spacings) / CGFloat(colors.count)
        return CGSize(width: cellBorder, height: cellBorder)
    }
    
    // MARK: Setup actions
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        cropButton.addTarget(self, action: #selector(cropButtonTapped), for: .touchUpInside)
        drawButton.addTarget(self, action: #selector(drawButtonTapped), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
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
        view.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        view.addSubview(topGradient)
        NSLayoutConstraint.activate([
            topGradient.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topGradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topGradient.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func layoutTopToolbar() {
        view.addSubview(topToolbar)
        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        view.addSubview(bottomGradient)
        NSLayoutConstraint.activate([
            bottomGradient.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomGradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomGradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomGradient.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func layoutBottomToolbar() {
        view.addSubview(bottomToolbar)
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -12)
        ])
    }
    
    private func layoutDeleteView() {
        view.addSubview(deleteView)
        NSLayoutConstraint.activate([
            deleteView.heightAnchor.constraint(equalToConstant: 50),
            deleteView.widthAnchor.constraint(equalToConstant: 50),
            deleteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
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
        
        view.addSubview(colorPickerView)
        NSLayoutConstraint.activate([
            colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorPickerView.heightAnchor.constraint(equalToConstant: 40),
            colorPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: safeAreaInsetsBottom * -1)
        ])
        colorPickerViewBottomConstraint = colorPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        colorPickerViewBottomConstraint.isActive = true
    }
    
    private func layoutColorsCollectionView() {
        colorPickerView.addSubview(colorsCollectionView)
        let collectionViewHeight = calculateColorCellSize().height
        NSLayoutConstraint.activate([
            colorsCollectionView.topAnchor.constraint(equalTo: colorPickerView.topAnchor),
            colorsCollectionView.leadingAnchor.constraint(equalTo: colorPickerView.leadingAnchor, constant: 16),
            colorsCollectionView.trailingAnchor.constraint(equalTo: colorPickerView.trailingAnchor, constant: -16),
            colorsCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
    ])
    }
}

extension PhotoEditorViewController: ColorDelegate {
    func didSelectColor(color: UIColor) {
        if isDrawing {
            self.drawColor = color
        } else if activeTextView != nil {
            activeTextView?.textColor = color
            textColor = color
        }
    }
}
