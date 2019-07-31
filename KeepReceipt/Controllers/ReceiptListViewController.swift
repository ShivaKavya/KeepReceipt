//
//  ReceiptListViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-06-26.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ReceiptListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let realm = try! Realm()

    var selectedCategory: Category?
    {
        didSet {
            
           
            
        }
    }
   
    @IBOutlet var receiptList: UITableView!
    
    var receiptNames : Results<ReceiptDetails>?
    var receiptDetails: ReceiptDetails?
    {
        didSet {
            
           
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        retrievingName()
        self.receiptList.reloadData()
        
        self.receiptList.delegate = self
        self.receiptList.dataSource = self
        
       // print(receiptNames as Any)
    }
    
    func retrievingName()
    {
        receiptNames = selectedCategory?.rDetails.sorted(byKeyPath: "rName")
        
        //  receiptNames = realm.objects(ReceiptDetails.self)
        
       //   receiptList.reloadData()
        
//        if(receiptNames!.count  > 0)
//                {
//                    self.receiptDetails = receiptNames?[0]
//
//                }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptNames?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptNames", for: indexPath)
        
        cell.textLabel?.text = receiptNames?[indexPath.row].rName ?? "No Receipts added yet"
       
        return cell
        
    }

    @IBAction func addReceipt(_ sender: UIButton) {
        
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "rd") as! ReceiptDetailsViewController
       
         navigationController?.pushViewController(next, animated: true)
        
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let item = receiptNames?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting Item, \(error)")
            }
        }
    }
    
    @IBAction func deleteReceipt(_ sender: UIButton) {
        
        
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
