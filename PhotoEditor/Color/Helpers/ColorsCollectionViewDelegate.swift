//
//  PhotoEditorView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 12.09.2024.
//

import UIKit

class ColorsCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let displayedView: UIView
    var colorDelegate : ColorDelegate?
    var colors: [UIColor] = []
    
    var activeIndexPath: IndexPath!
    
    static var HORIZONTAL_SPACING: CGFloat = 12
    
    init(displayedView: UIView) {
        self.displayedView = displayedView
        super.init()
        setupColor()
    }
    
    func resetColor(collectionView: UICollectionView) {
        setupColor()
        collectionView.reloadData()
    }
    
    func setUnselected(collectionView: UICollectionView) {
        activeIndexPath = nil
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activeIndexPath = indexPath
        colorDelegate?.didSelectColor(color: colors[indexPath.item])
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        cell.setupCell(isSelected: activeIndexPath == indexPath , color: colors[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Self.HORIZONTAL_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 24.0, height: 24.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 24 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 12 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    private func setupColor() {
        activeIndexPath = IndexPath(row: 0, section: 0)
    }
}
