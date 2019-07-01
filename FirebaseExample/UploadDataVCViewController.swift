//
//  UploadDataVCViewController.swift
//  FirebaseExample
//
//  Created by Eleyan Saad on 6/30/19.
//  Copyright © 2019 Eleyan Saad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import MBProgressHUD



class UploadDataVCViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var img_show: UIImageView!
    @IBOutlet weak var txt_title: UITextField!
    
    var pickerImage:UIImagePickerController!

    var imageAtt = UIImage()
    var ref=DatabaseReference.init()
    
    var photoUrl = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func uploadButt(_ sender: Any) {
        uploadData()
        
        
    }
    
    
    
    @IBAction func selectPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.videoQuality = .typeLow;
        self.present(picker, animated: true, completion: nil)
        
        
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.barTintColor = UIColor(red: 40.0/255.0, green: 168.0/255.0, blue: 240.0/255.0, alpha: 1)
        picker.navigationBar.topItem?.rightBarButtonItem?.title = "الغاء"
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        img_show.image = selectedImage
        imageAtt = selectedImage
        print(imageAtt)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func uploadData(){
        
        
         showHUD(title: "Uploading")
        let imageData = imageAtt.jpegData(compressionQuality: 0.3)

        let timeStamp = String(Int(NSDate.timeIntervalSinceReferenceDate*1000))
       
        
        let imagename=timeStamp
        let imagepath="Image_Storage/\(timeStamp)/\(imagename).jpg"
        let mounref = Storage.storage().reference().child(imagepath)
        

        
        let metadata = StorageMetadata()
        metadata.contentType="image/jpg"
        mounref.putData(imageData as! Data, metadata: metadata) { (metaData, error) in
            mounref.downloadURL(completion: { (url, err) in
                if let urltext=url?.absoluteString{
                    self.photoUrl=urltext
                    
                    let msg=[
                        "title":self.txt_title.text!,
                        "ImagePath":urltext
                        ] as [String:Any]
                    
                    
                    
                    
                    let FirebaseMessage = self.ref.childByAutoId()
                    FirebaseMessage.setValue(msg) { (error, dataRef) in
                        if(error != nil) {
                            
                            
                            
                            //if there was an error saving post, display alert informing user
                            print(dataRef)
                            
                        }else {
                            self.showHUD(title: "Done", details: "", hideAfter: 1)

                            
                            print(dataRef)
                            
                        }
              
    }
                }
            })}
                    
                    
                }

}








///Extention

extension UIViewController {
    
    func showHUD(title:String?, details: String? = nil, hideAfter:TimeInterval? = nil) {
        var hud: MBProgressHUD! = MBProgressHUD(for: view)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
        }
        
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = details
        if let hideAfter = hideAfter {
            hud.hide(animated:true, afterDelay:hideAfter)
        }
    }
    
    func showIndeterminateHUD(title:String? = nil, details: String? = nil) {
        var hud: MBProgressHUD! = MBProgressHUD(for: view)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
        }
        
        hud.mode = .indeterminate;
        hud.label.text = title
        hud.detailsLabel.text = details
    }
    
    func hideHUD(animated:Bool = true) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}

