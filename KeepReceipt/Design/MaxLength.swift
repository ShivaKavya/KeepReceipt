//
//  MaxLength.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-07-21.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import UIKit


private var kAssociationKeyMaxLength: Int = 0
private var kAssociationKeyMaxLengthTextView: Int = 0

extension UITextField {
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

extension UITextView:UITextViewDelegate {
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLengthTextView) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            self.delegate = self
            
            objc_setAssociatedObject(self, &kAssociationKeyMaxLengthTextView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textField: self)
    }
    @objc func checkMaxLength(textField: UITextView) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
        
        
        
    }
}
