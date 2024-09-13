import UIKit

public final class PhotoEditorViewController: UIViewController {
    
    var contentView = PhotoEditorView()
    public var image: UIImage?
    public var colors  : [UIColor] = [] // array of Colors that will show while drawing or typing
    public var photoEditorDelegate: PhotoEditorDelegate?
    lazy var colorsCollectionViewDelegate: ColorsCollectionViewDelegate = ColorsCollectionViewDelegate(displayedView: view)
    public var hiddenControls : [Control] = []  // list of controls to be hidden
    
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
    
    public override func loadView() {
        registerFont()
        contentView.colors = colors
        view = contentView
        // super.loadView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        self.setImageView(image: image!)
        
        contentView.deleteView.layer.cornerRadius = contentView.deleteView.bounds.height / 2
        contentView.deleteView.layer.borderWidth = 2.0
        contentView.deleteView.layer.borderColor = UIColor.white.cgColor
        contentView.deleteView.clipsToBounds = true
        
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
        
        contentView.colorsCollectionView.collectionViewLayout = layout
        colorsCollectionViewDelegate.colorDelegate = self
        
        if !colors.isEmpty {
            colorsCollectionViewDelegate.colors = colors
        }
        
        contentView.colorsCollectionView.delegate = colorsCollectionViewDelegate
        contentView.colorsCollectionView.dataSource = colorsCollectionViewDelegate
        contentView.colorsCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.id)
    }
    
    func setImageView(image: UIImage) {
        contentView.imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        contentView.imageViewHeightConstraint.constant = (size?.height)!
    }
    
    func hideToolbar(hide: Bool) {
        contentView.topToolbar.isHidden = hide
        contentView.topGradient.isHidden = hide
        contentView.bottomToolbar.isHidden = hide
        contentView.bottomGradient.isHidden = hide
    }
    
    // MARK: Setup actions
    
    private func setupActions() {
        contentView.closeButton.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        contentView.cropButton.addTarget(self, action: #selector(cropButtonTapped), for: .touchUpInside)
        contentView.drawButton.addTarget(self, action: #selector(drawButtonTapped), for: .touchUpInside)
        contentView.textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        contentView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        contentView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        contentView.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        contentView.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
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
