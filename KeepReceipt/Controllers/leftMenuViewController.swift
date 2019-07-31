//
//  leftMenuViewController.swift
//  KeepReceipt
//
//  Created by Shiva Kavya on 2019-07-26.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class leftMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var firstName: String = ""
    var lastName: String = ""
    var bankAccountNumber: String = ""

    var userData: Results<Data>?

    var profileDetails: Data?
    {
        didSet { }
    }
    
    let realm = try! Realm()
    
     var categories: Results<Category>? //groupNames = categories
    
    @IBOutlet var addUser: UIButton!
    
    @IBOutlet var firstNameLbl: UILabel!
    
    @IBOutlet var lastNameLbl: UILabel!
    
    
    @IBOutlet var banLbl: UILabel!
    

    @IBOutlet var groupTabel: UITableView!
    @IBOutlet var profilePicture: RoundImage!
    
    
    
    @IBOutlet var addGroup: UIButton!
    
    @IBOutlet var deleteGroup: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Left Menu"
        loadReceiptGroups()
        
      
        self.groupTabel.delegate = self
        self.groupTabel.dataSource = self
        
     //   groupTabel.reloadData()
     //   groupTabel.separatorStyle = .none
        
        updateUserData()
        
        firstNameLbl.text = profileDetails?.firstName
        lastNameLbl.text = profileDetails?.lastName
        banLbl.text = profileDetails?.bankAccountNumber

        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderWidth = 0

        print(userData as Any)

    }
    
    func updateUserData()
    {
        userData = realm.objects(Data.self)

        if(userData!.count > 0){

            self.profileDetails = userData?[0]
        }

    }
    
//    func access()
//    {
//        
//        while firstNameLbl.text == ""{
//            
//            addUser.isHidden
//            
//        }
//        
//    }
    
    
    
    
    func loadReceiptGroups()
    {
        
        categories = realm.objects(Category.self)
        
        groupTabel.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = groupTabel.dequeueReusableCell(withIdentifier: "GroupNameCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yET"
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        self.performSegue(withIdentifier: "ReceiptList", sender: self)

        self.groupTabel.reloadData()

    }
    
    
    
    @IBAction func addUserAction(_ sender: UIButton) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        
        navigationController?.pushViewController(next, animated: true)
    
        
    }
    
    
   
    @IBAction func addAction(_ sender: UIButton) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "ReceiptGroup") as! ReceiptGroupViewController
        
        navigationController?.pushViewController(next, animated: true)
    
    }
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as! ReceiptListViewController

            if let indexPath = groupTabel.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
       
    }
    

}
