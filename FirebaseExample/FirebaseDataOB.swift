//
//  FirebaseData.swift
//  FirebaseExample
//
//  Created by Eleyan Saad on 6/30/19.
//  Copyright © 2019 Eleyan Saad. All rights reserved.
//

import Foundation
import UIKit


class ExampleOB{
    
    
    var Id:Int?
    var photoUrl:String?
    var title:String?
    
    
    init (info: Dictionary<String, AnyObject>){
     
//        if let id = info["id"] as? Int {
//            self.Id = id
//        }
//
        if let photoUrl = info["ImagePath"] as? String {
            self.photoUrl = photoUrl
        }
        
        if let title = info["title"] as? String {
            self.title = title
        }
        
    }
    
}

