//
//  CollectionViewCell.swift
//  insta_iqon
//
//  Created by ryota-ko on 2015/07/23.
//  Copyright (c) 2015年 ryota-ko. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
