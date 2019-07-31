//
//  ViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-05-24.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var leftMenu: UIBarButtonItem!
    
    let realm = try! Realm()
    
    
    var categories: Results<Category>? //groupNames = categories
    
    var allReceipts : Results<ReceiptDetails>?
    
    var allReceiptNames: ReceiptDetails?
    {
        didSet {
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.title = "All Receipts"
        
       loadAllReceipts()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self 
        
       tableView.separatorStyle = .none
        print(allReceipts as Any)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return allReceipts?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "AllReceipts", for: indexPath)
        
        cell.textLabel?.text = allReceipts?[indexPath.row].rName ?? "No Receipts added yet"
        
    return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "DetailsVC", sender: self)
        
        self.tableView.reloadData()

   }
    
   // sending category data to receipt list
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "DetailsVC" {
        let destinationVC = segue.destination as! DetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
         }
        }
        else if segue.identifier == "ReceiptList"{
            _ = segue.destination as! ReceiptListViewController
            // destinationVC.ReceiptGroup = self.
        }
        else if segue.identifier == "profileVC"{
            _ = segue.destination as! ProfileViewController
        }
    }
 
 
    //retrieving all receipts
    
    func loadAllReceipts()
    {
        
        allReceipts = realm.objects(ReceiptDetails.self)

        tableView.reloadData()
        
        if(allReceipts!.count > 0){
            
            self.allReceiptNames = allReceipts?[0]
        }
    }
    
    
    
    
    //hiding & displaying left menu
    
    @IBAction func leftMenuAction(_ sender: Any) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "leftMenu") as! leftMenuViewController
        
        navigationController?.pushViewController(next, animated: true)
       
    }
    
    
    
}




