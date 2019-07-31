//
//  ReceiptDetails.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-06-29.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import RealmSwift


class ReceiptDetails : Object {
    
    @objc dynamic var rName: String = ""
    @objc dynamic var rDescription: String = ""
    @objc dynamic var rDate: String = ""
    @objc dynamic var rAmount: String = ""
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "rDetails")
    
    
}
