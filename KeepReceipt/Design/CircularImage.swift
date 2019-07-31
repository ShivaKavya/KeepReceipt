//
//  CircularImage.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-07-21.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import UIKit


//@IBDesignable class CustomImageView: UIImageView {
//    override func prepareForInterfaceBuilder() {
//        self.layer.cornerRadius = self.bounds.size.width/2
//        
//        self.layer.masksToBounds = true
//    }
//}

@IBDesignable
class RoundImage: UIImageView{
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // set border width
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    // set border color
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        self.clipsToBounds = true
    }
    
    
}// class
