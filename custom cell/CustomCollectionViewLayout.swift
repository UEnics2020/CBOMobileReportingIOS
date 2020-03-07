//
//  CustomCollectionViewLayout.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 29/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import Foundation
import UIKit
class CustomCollectionViewLayout {
    

    func MyCollectionViewLayoutSet(collectionView : UICollectionView  , collectionViewLayout : UICollectionViewFlowLayout ) -> CGSize {
        let numberOfItemsPerRow : Int = 3
        let flowLayout = collectionViewLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
    
        return CGSize(width: size , height: size + 20)
    
    }
    
    
     func MycollectionViewCellSpaceing(collectionView : UICollectionView ) ->  UICollectionViewFlowLayout {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:10,left:10,bottom:10,right:10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        return layout
    }
    
    
}

