//
//  ColorsCollectionViewDelegate.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 5/1/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

class ColorsCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static var HORIZONTAL_SPACING: CGFloat = 5
    
    
    var colorDelegate : ColorDelegate?
    let displayedView: UIView
    
    
    /**
     Array of Colors that will show while drawing or typing
     */
    var colors = [
        UIColor.black,
        UIColor.darkGray,
        UIColor.gray,
        UIColor.lightGray,
        UIColor.white,
        UIColor.blue,
        UIColor.green,
        UIColor.red,
        UIColor.yellow,
        UIColor.orange,
        UIColor.purple,
        UIColor.cyan,
        UIColor.brown,
        UIColor.magenta
    ]
    
    init(displayedView: UIView) {
        self.displayedView = displayedView
        super.init()
    }
    
    var stickersViewControllerDelegate : StickersViewControllerDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colorDelegate?.didSelectColor(color: colors[indexPath.item])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        cell.colorView.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Self.HORIZONTAL_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateColorCellSize()
    }
    
    private func calculateColorCellSize() -> CGSize {
        let collectionWidth: CGFloat = displayedView.frame.width - (16 * 2)
        let spacings = CGFloat(colors.count - 1) * ColorsCollectionViewDelegate.HORIZONTAL_SPACING
        let cellBorder = (collectionWidth - spacings) / CGFloat(colors.count)
        return CGSize(width: cellBorder, height: cellBorder)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidth: CGFloat = flowLayout.itemSize.width
//        let cellSpacing: CGFloat = flowLayout.minimumInteritemSpacing
//        var cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
//        var collectionWidth = collectionView.frame.size.width
//        var totalWidth: CGFloat
//        if #available(iOS 11.0, *) {
//            collectionWidth -= collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
//        }
//        repeat {
//            totalWidth = cellWidth * cellCount + cellSpacing * (cellCount - 1)
//            cellCount -= 1
//        } while totalWidth >= collectionWidth
//
//        if (totalWidth > 0) {
//            let edgeInset = (collectionWidth - totalWidth) / 2
//            return UIEdgeInsets.init(top: flowLayout.sectionInset.top, left: edgeInset, bottom: flowLayout.sectionInset.bottom, right: edgeInset)
//        } else {
//            return flowLayout.sectionInset
//        }
//    }
}
