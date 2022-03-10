//
//  DashboardView.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//  
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
/*
 View: displays what it is told to by the Presenter and relays user input back to the Presenter, the View is passive. It waits for the Presenter to give it content to display.
 
 Use the data sent by the presenter, and display it. Can also pass touch events, but will simply notify the presenter of this, where the work to process the touch takes place. In practice the view sets up the presenter (owns it), and sends messages to the same.
 */

class DashboardView: UIViewController {
    /*
     Replace UIViewController to UITableViewController or UICollectionViewController if needed
     */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uploadImage: UIButton!
    
    // MARK: Properties
    var presenter: DashboardViewToPresenterProtocol?
    let dbController = FirebaseDatabaseController()
    
//    var ref : DatabaseReference!
    
//    private let storage = Storage.storage().reference()
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    
    var nameUser = String()
    var imageSave = UIImage()
    var imageSaveData = Data()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        ref =  Database.database().reference()
        setup()
        presenter?.didLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        if imageSave.size.width == 0 {
            uploadImage.isEnabled = false
        }
    }
    
    func setup() {
        // Do any aditional setup after loading the view ex: View properties, navigation properties, etc.
        dbController.observe(endpoint: "hex") { snapshot in
            guard snapshot.exists() else { return }
            let dictionaryValue = snapshot.value as? String
            let stringValue = dictionaryValue
            Listener.shared.dataString = stringValue
            if stringValue!.contains("#"){
                self.view.backgroundColor = UIColor(hex: stringValue!)
            }else{
                self.view.backgroundColor = UIColor(hex: "#DCDCDC")
            }
            
            NotificationCenter.default.post(name: .testKey, object: nil)
        }
    }
    
    func numberRandom(digits:Int) -> String{
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func updateImage(_ sender: Any) {
        let fileName = "\(nameUser).png"
        let ref = imageReference.child(fileName)
        let uploadTask = ref.putData(imageSaveData, metadata: nil) { (metadata, error) in
            print("upload finish")
            print(metadata ?? "no metadata")
            print(error ?? "no error")
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "no more progrees")
        }
        
        uploadTask.resume()
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "seleccionar", message: "", preferredStyle: .actionSheet)
        
        if imageSave.size.width == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                imagePicker.sourceType = .camera
                imagePicker.cameraDevice = .front
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("la camara no esta habilitada")
            }
        }else{
            actionSheet.addAction(UIAlertAction(title: "Tomar una nueva foto", style: .default, handler: { (action:UIAlertAction) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    imagePicker.sourceType = .camera
                    imagePicker.cameraDevice = .front
                    self.present(imagePicker, animated: true, completion: nil)
                }else{
                    print("la camara no esta habilitada")
                }
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Visualizar foto anterior", style: .default, handler: { (action:UIAlertAction) in
                
                let vc = UIStoryboard.overFullScreen(type: .viewImage) as! ViewImageViewController
                vc.imageRecive = self.imageSave
                self.present(vc, animated: true, completion: { })
                
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil )
        
    }
    
    func resizeImage(image: UIImage) -> Data {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.pngData()
        UIGraphicsEndImageContext()
        return imageData!
    }

}

extension Notification.Name {
    static let testKey = Notification.Name.init(rawValue: "testValueNotification")
}


extension DashboardView: DashboardPresenterToViewProtocol {
    func showData(_ model: ServiceResponse) {

    }

}

extension DashboardView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        imageSave = image
        imageSaveData = resizeImage(image: image)
        uploadImage.isEnabled = true
        picker.dismiss(animated: true)

    }
}

extension DashboardView: textfieldDelegate {
    func returnString(string: String) {
        nameUser = string.replacingOccurrences(of: " ", with: "")
    }
    
    
}

extension DashboardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 78
        case 1:
            return 78
        case 2:
            return 78
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldViewCell") as! TextFieldViewCell
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldViewCell") as! TextFieldViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoViewCell") as! PhotoViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GraphViewCell") as! GraphViewCell
            return cell
        default:
            print("")
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            openCamera()
        }
        if indexPath.row == 2{
            presenter?.showDetail()
        }
    }
}
