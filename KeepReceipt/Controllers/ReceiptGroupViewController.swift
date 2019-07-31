//
//  ReceiptGroupViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-06-20.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ReceiptGroupViewController: UIViewController {
    
    @IBOutlet var save: UIButton!
    @IBOutlet var groupName: UITextField!
    
    let realm = try! Realm()
    
  //  var groupNames = [Category]()
    
    var groupNamesList: Results<Category>?

    @IBAction func groupNameAction(_ sender: UITextField) {
        
        groupName.text?.removeAll()
        
        
    }
    
    @IBAction func saveGroupName(_ sender: UIButton) {
    
        if(groupName.text == ""){
            
            showAlertWith(title: "Group Name can't be saved", message: "Enter a name")
        }
        else{
            
            let newGroupName = Category()
            newGroupName.name = groupName.text!
            
            do {
                try realm.write {
                    realm.add(newGroupName)
                   // showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
                }
            } catch {
                showAlertWith(title: "Error saving Data", message: error.localizedDescription)
                print("Error saving data \(error)")
            }
            groupNameAction(groupName)
            
            loadReceiptGroups()
            
            let GroupsName = groupNamesList
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = myStoryBoard.instantiateViewController(withIdentifier: "leftMenu") as! leftMenuViewController
            nextVC.categories = GroupsName

            navigationController?.pushViewController(nextVC, animated: true)
            
        }
        
    }
    
    func loadReceiptGroups()
    {
        groupNamesList = realm.objects(Category.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

    // MARK: - Navigation
   /*
     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let GroupsName = groupNamesList
     
        if segue.identifier == "groupList" {
            if let vc = segue.destination as? ViewController {
                vc.groupNames = GroupsName
            }
        }

        }
   */
}
