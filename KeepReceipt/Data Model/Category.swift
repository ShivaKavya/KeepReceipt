//
//  Category.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-06-20.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name: String = ""
    
    let rDetails = List<ReceiptDetails>()

}
