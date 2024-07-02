import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    static let id = "ColorCollectionViewCell"

    let colorView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: 28, height: 28)
        let view = UIView(frame: rect)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.clipsToBounds = true
        colorView.layer.borderWidth = 1.0
        colorView.layer.borderColor = UIColor.white.cgColor
        contentView.addSubview(colorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
