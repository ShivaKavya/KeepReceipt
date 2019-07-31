//
//  DetailsViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-06-26.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let realm = try! Realm()
    
    var receiptList: Results<ReceiptDetails>?

    @IBOutlet var receiptName: UITextField!
    
    @IBOutlet var receiptDescription: UITextField!
    
    @IBOutlet var receiptDate: UITextField!
    
    @IBOutlet var receiptAmount: UITextField!
    
    @IBOutlet var save: UIButton!
    
    @IBOutlet var receiptImage: UIImageView!
    
    var selectedCategory: Category?
    {
        didSet {
            
            fetchData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showDate()
        
        receiptAmount.delegate = self
        receiptAmount.keyboardType = .decimalPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = selectedCategory?.name
        
    }
    
    func showDate()
    {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        receiptDate.text = formattedDate
        
    }
 
    func checkAlert()
    {
        if(receiptName.text == " " || receiptDescription.text == " " || receiptDate.text == " " || receiptAmount.text == " ")
        {
            showAlertWith(title: "Error", message: "Fill all the details")
        }
    }
    
    func checkRealm()
    {
        if let currentCategory = self.selectedCategory{
            do {
                try self.realm.write {
                    let details = ReceiptDetails()
                    details.rName = receiptName.text!
                    details.rDescription = receiptDescription.text!
                    details.rDate = receiptDate.text!
                    details.rAmount = receiptAmount.text!
                    
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
    
    func saveData()
    
    {
        
        if(receiptName.text == " " || receiptDescription.text == " " || receiptDate.text == " " || receiptAmount.text == " ")
        {
            showAlertWith(title: "Error", message: "Fill all the details")
        }
        else{
            if let currentCategory = self.selectedCategory{
            do {
                try self.realm.write {
                    let details = ReceiptDetails()
                    details.rName = receiptName.text!
                    details.rDescription = receiptDescription.text!
                    details.rDate = receiptDate.text!
                    details.rAmount = receiptAmount.text!
                    
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
    
   
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Image Saved", message: "Your image has been saved to your photos.")
        }
    }
   
    
    @IBAction func snapshot(_ sender: UIButton) {
        
        
       // saveData()
        
        print("Button Tapped")
     
        let image = UIImagePickerController()
        image.delegate = self

        image.allowsEditing = false
        image.sourceType = UIImagePickerController.SourceType.camera
        self.present(image, animated: true)
        saveImage()
      
    }
    @IBAction func testAction(_ sender: UIButton) {
         saveData()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        saveData()
        
        fetchData()
        
        let recNames = receiptList
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "receiptList") as! ReceiptListViewController
        next.receiptNames = recNames


        navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func testButton(_ sender: UIButton) {
        saveData()
    }
    
    func saveImage()
    {
        guard let selectedImage = receiptImage.image else {
            print("Snapshot not saved!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func fetchData()
    {
//        receiptList = selectedCategory?.rDetails.sorted(byKeyPath: "rName")
//
//        // receiptList = realm.objects(ReceiptDetails.self)
//
//        print(receiptList as Any)
        
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

extension DetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let decimalSeparator = NSLocale.current.decimalSeparator else {
            return true
        }

        var splitText = text.components(separatedBy: decimalSeparator)
        let totalDecimalSeparators = splitText.count - 1
        let isEditingEnd = (text.count - 3) < range.lowerBound

        splitText.removeFirst()

        // Check if we will exceed 2 dp
        if
            splitText.last?.count ?? 0 > 1 && string.count != 0 &&
            isEditingEnd
        {
            return false
        }

        // If there is already a dot we don't want to allow further dots
        if totalDecimalSeparators > 0 && string == decimalSeparator {
            return false
        }

        // Only allow numbers and decimal separator
        switch(string) {
        case "", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", decimalSeparator:
            return true
        default:
            return false
        }
    }
}
