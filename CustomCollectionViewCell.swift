//
//  CustomCollectionViewCell.swift
//  EversnapAssignment
//
//  Created by sophie hoarau on 20/01/2016.
//  Copyright © 2016 StephenHoarau. All rights reserved.
//

import UIKit

//CustomCell to display pictures

class CustomCollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
