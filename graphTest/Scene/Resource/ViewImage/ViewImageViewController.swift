//
//  ViewImageViewController.swift
//  graphTest
//
//  Created by Javier Hernandez on 24/09/21.
//

import UIKit

class ViewImageViewController: UIViewController {


    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    var imageRecive = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        image.image = imageRecive
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }

}
