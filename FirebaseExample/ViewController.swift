//
//  ViewController.swift
//  FirebaseExample
//
//  Created by Eleyan Saad on 6/30/19.
//  Copyright © 2019 Eleyan Saad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher
import MBProgressHUD


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    
    
    var dataOB:[ExampleOB]=[]
    
    var ref: DatabaseReference!


    
    @IBOutlet weak var tableview: UITableView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loadData()
        tableview.reloadData()
        print("sami")
    }
    
    
    func loadData(){
        
        showHUD(title: "Loading")
         ref.observe(.value,with: { (snapshot) in
            
            
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    
                    for snap in snapshot{
                        
                        print(snapshot)
                        if let postDict=snap.value as? Dictionary<String, AnyObject>{
                            
                            
                            
                            
                            self.dataOB.append(ExampleOB(info: postDict))
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
            self.showHUD(title: "Done", details: "", hideAfter: 1)
                self.tableview.reloadData()
            })
        
            
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataOB.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
            
            let obj = dataOB[indexPath.row]
            
            cell?.lbl_title.text = obj.title
            let url = URL(string: obj.photoUrl!)
            
            cell?.image_adds.kf.setImage(with: url!)
            
            print(obj.title)
            
            
            return cell!
        }
        
    
  
    
    
    
    
    


}

