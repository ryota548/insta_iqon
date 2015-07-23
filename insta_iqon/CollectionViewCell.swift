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
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
