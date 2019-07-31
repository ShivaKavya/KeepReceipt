//
//  ReceiptDetailsViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-07-31.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ReceiptDetailsViewController: UIViewController {

    @IBOutlet var descriptionValue: UITextField!
    @IBOutlet var receiptNameValue: UITextField!
    
    @IBOutlet var amountValue: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var selectedCategory: Category?
    {
        didSet {
            
            // fetchData()
            
        }
    }
    
    func saveData()
        
    {
        
        if(receiptNameValue.text == " " || descriptionValue.text == " " || amountValue.text == " ")
        {
            showAlertWith(title: "Error", message: "Fill all the details")
        }
        else{
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                        let details = ReceiptDetails()
                        details.rName = receiptNameValue.text!
                        details.rDescription = descriptionValue.text!
                        
                        details.rAmount = amountValue.text!
                        
                        currentCategory.rDetails.append(details)
                        showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
                        
                    }
                }
                    
                catch {
                    showAlertWith(title: "Error saving Data", message: error.localizedDescription)
                    print("Error saving data \(error)")
                }
                
                
            }
        }
        
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    

    @IBAction func SaveData(_ sender: UIButton) {
        
        saveData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
