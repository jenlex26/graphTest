//
//  UIStoryboard+Addons.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//

import Foundation
import UIKit

enum StoryBoard:String {
    
    case main         = "Main"
    case detailGraph  = "DetailGraphScene"
    case viewImage    = "ViewImageScene"

    

    func name() -> String {
        return self.rawValue
    }
}

extension UIStoryboard {
    
    static func type(type:StoryBoard) -> UIViewController {
        UIStoryboard(name: type.name(), bundle: nil).instantiateInitialViewController()!
    }
    
    static func type(type:StoryBoard, and identifier:String) -> UIViewController {
        UIStoryboard(name: type.name(), bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    static func overFullScreen(type:StoryBoard) -> UIViewController {
        let vc = UIStoryboard(name: type.name(), bundle: nil).instantiateInitialViewController()!
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
    static func overFullScreen(type:StoryBoard, and identifier:String) -> UIViewController {
        let vc = UIStoryboard(name: type.name(), bundle: nil).instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    static func popover(type:StoryBoard, and identifier:String) -> UIViewController {
        let vc = UIStoryboard(name: type.name(), bundle: nil).instantiateViewController(withIdentifier: identifier)
            vc.modalPresentationStyle = .popover
        return vc
    }
    
}
