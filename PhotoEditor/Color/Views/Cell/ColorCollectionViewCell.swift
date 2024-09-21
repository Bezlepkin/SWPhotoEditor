import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    
    static let id = "ColorCollectionViewCell"
    
    let innerCircleIndent: CGFloat = 5
    
    let outerСircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let innerСircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutColorView()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        outerСircleView.backgroundColor = .clear
        innerСircleView.backgroundColor = .clear
        outerСircleView.layer.borderWidth = 1.0
        outerСircleView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupCell(isSelected: Bool, color: UIColor) {
        outerСircleView.backgroundColor = color
        
        if (isSelected) {
            outerСircleView.backgroundColor = .black
            innerСircleView.backgroundColor = color
            outerСircleView.layer.borderWidth = 3.0
            outerСircleView.layer.borderColor = color.cgColor
            
            if (isDarkColor(color: color)) {
                let colorGray: UIColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1)
                outerСircleView.layer.borderColor = colorGray.cgColor
                innerСircleView.backgroundColor = colorGray
            }
        }
    }
    
    private func setupViews() {
        outerСircleView.layer.cornerRadius = contentView.frame.width / 2
        outerСircleView.clipsToBounds = true
        outerСircleView.layer.borderWidth = 2.0
        outerСircleView.layer.borderColor = UIColor.white.cgColor
        
        innerСircleView.layer.cornerRadius = (contentView.frame.width - innerCircleIndent * 2) / 2
        innerСircleView.clipsToBounds = true
        
        outerСircleView.addSubview(innerСircleView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            outerСircleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerСircleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerСircleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerСircleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            innerСircleView.widthAnchor.constraint(equalToConstant: 14),
            innerСircleView.heightAnchor.constraint(equalToConstant: 14),
            innerСircleView.topAnchor.constraint(equalTo: outerСircleView.topAnchor, constant: innerCircleIndent),
            innerСircleView.leftAnchor.constraint(equalTo: outerСircleView.leftAnchor, constant: innerCircleIndent)
        ])
    }
    
    private func layoutColorView() {
        contentView.addSubview(outerСircleView)
        NSLayoutConstraint.activate([
            outerСircleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerСircleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerСircleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerСircleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func isDarkColor(color: UIColor) -> Bool {
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;

        if (brightness < 0.1) {
            return true
        }
        
        return false
    }
}
