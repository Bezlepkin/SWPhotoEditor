import UIKit

public final class PhotoEditorViewController: UIViewController {
    // The image to be processed
    @objc public var image: UIImage?
    // Array of colors that will show while drawing or typing
    // public var colors: [UIColor] = []
    @objc public var photoEditorDelegate: PhotoEditorDelegate?
    lazy var colorsCollectionViewDelegate: ColorsCollectionViewDelegate = ColorsCollectionViewDelegate(displayedView: view)
    lazy var contentView = PhotoEditorView(frame: view.frame, colors: colors)

    var drawColor: UIColor = UIColor.black
    var textColor: UIColor = UIColor.white
    var lastPoint: CGPoint!
    var swiped = false
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    var lastTextViewFont:UIFont?
    var activeTextView: UITextView?
    var imageViewToPan: UIImageView?
    var isTyping: Bool = false
    
    // Active mode name
    var activeMode: ModeType?
    // The image we work with during processing
    var currentImage: UIImage!
    
    public var colors: [UIColor] = [
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

    public override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        self.setImage(image: image!)
        
        contentView.deleteView.layer.cornerRadius = contentView.deleteView.bounds.height / 2
        contentView.deleteView.layer.borderWidth = 2.0
        contentView.deleteView.layer.borderColor = UIColor.white.cgColor
        contentView.deleteView.clipsToBounds = true
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .bottom
        edgePan.delegate = self
        self.view.addGestureRecognizer(edgePan)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 28, height: 28)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        contentView.colorsCollectionView.collectionViewLayout = layout
        colorsCollectionViewDelegate.colorDelegate = self
        
        if !colors.isEmpty {
            colorsCollectionViewDelegate.colors = colors
        }
        
        contentView.colorsCollectionView.delegate = colorsCollectionViewDelegate
        contentView.colorsCollectionView.dataSource = colorsCollectionViewDelegate
        contentView.colorsCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.id)
    }
    
    func setImage(image: UIImage) {
        currentImage = image
        contentView.imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        contentView.imageViewHeightConstraint.constant = (size?.height)!
    }
    
    func hideToolbar(hide: Bool) {
        contentView.topToolbar.isHidden = hide
        // contentView.topGradient.isHidden = hide
        contentView.bottomToolbar.isHidden = hide
        // contentView.bottomGradient.isHidden = hide
    }
    
    func setActionsToolbarVisibility(visibility: Bool) {
        contentView.actionsToolbar.isHidden = !visibility
    }
    
    func setColorPickerVisibility(visibility: Bool) {
        contentView.colorPickerView.isHidden = !visibility
    }
    
    func setTypingCanvasViewVisibility(visibility: Bool) {
        contentView.typingCanvasView.isHidden = !visibility
    }
    
    // MARK: Setup actions
    
    private func setupActions() {
        contentView.closeButton.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        contentView.cancelButton.addTarget(self, action: #selector(cancelButtonWasTapped), for: .touchUpInside)
        contentView.cropButton.addTarget(self, action: #selector(cropButtonTapped), for: .touchUpInside)
        contentView.drawButton.addTarget(self, action: #selector(drawButtonTapped), for: .touchUpInside)
        contentView.textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        contentView.applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        contentView.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
}

extension PhotoEditorViewController: ColorDelegate {
    public func didSelectColor(color: UIColor) {
        if activeMode == ModeType.drawing {
            contentView.drawingView.color = color
        } else if activeMode == ModeType.typing {
            contentView.typingCanvasView.setColor(color: color)
        } else if activeTextView != nil {
            activeTextView?.textColor = color
            textColor = color
        }
    }
}
