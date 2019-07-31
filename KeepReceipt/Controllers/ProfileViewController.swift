//
//  ProfileViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-05-31.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let realm = try! Realm()
  //  var pickedPicture: UIImagePickerController!
    
    var data: Results<Data>?
    
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet var fnTextField: UITextField!
    
    @IBOutlet var lnTextField: UITextField!
    
    @IBOutlet var banTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  fnTextField.delegate = self
      //  lnTextField.delegate = self
    
    }
    
    
    
    // code to hide keyboard when tapped on screen
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for txt in self.view.subviews {
            if txt.isKind(of: UITextField.self) && txt.isFirstResponder {
                txt.resignFirstResponder()
            }
        }
    }

    
    func saveData()  {
        let data = Data()
        data.firstName = fnTextField.text!
        data.lastName = lnTextField.text!
        data.bankAccountNumber = banTextField.text!
        do {
            try realm.write {
                realm.add(data)
                showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
            }
        } catch {
            showAlertWith(title: "Error saving Data", message: error.localizedDescription)
            print("Error saving data \(error)")
        }
        
        guard let selectedImage = profilePicture.image else {
            print("Profile Picture not saved!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    // Code for saving user input in realm

    @IBAction func saveAction(_ sender: UIButton) {
        if(fnTextField.text == "" || lnTextField.text == "" || banTextField.text == ""){
            
            showAlertWith(title: "Data can't be saved", message: "Enter all the fields")
        }
        else{
            
            saveData()
            textFieldShouldClear()
            let retreivedData = data
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next = myStoryBoard.instantiateViewController(withIdentifier: "leftMenu") as! leftMenuViewController
            next.userData = retreivedData

            navigationController?.pushViewController(next, animated: true)
        }
        
    }
    
   
  func retrieveData()
  {
         data = realm.objects(Data.self)
    }
    
    
    @IBAction func profilePictureAction(_ sender: UIButton)
    {
    
        optionsForProfilePicture()
    
    }
    
    // Code for using picture taken on camera
    
  @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profilePicture.image = image
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func textFieldShouldClear() -> Bool {
        
       fnTextField.text!.removeAll()
       lnTextField.text!.removeAll()
       banTextField.text!.removeAll()
        return true
    }
    
    private func configureTextFields()
    {
        fnTextField.delegate = self
        lnTextField.delegate = self
        banTextField.delegate = self
        
    }
    
    private func configureTapGesture()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap()
    {
        print("Handle Tap was called")
        view.endEditing(true)
    }
    
    func optionsForProfilePicture() {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        
       
        let alert = UIAlertController(title: "How do you want to upload your picture?", message: "Choose either of the options", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            
            image.sourceType = UIImagePickerController.SourceType.camera
            self.present(image, animated: true)
            print("You've pressed Camera")
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
            
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(image, animated: true)
            print("You've pressed Photo Library")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("You've pressed cancel")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Image Saved", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
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


// hiding keyboard after entering text in uitextfield


extension ProfileViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fnTextField.resignFirstResponder()
        lnTextField.resignFirstResponder()
        
        return true
    }
}

