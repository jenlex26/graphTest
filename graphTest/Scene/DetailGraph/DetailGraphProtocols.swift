//
//  DetailGraphProtocols.swift
//  graphTest
//
//  Created by Javier Hernandez on 24/09/21.
//  
//

import Foundation
import UIKit

/*
 Protocols: Defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
 */

protocol DetailGraphPresenterToViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    func showData(_ model: ServiceResponse)
}

protocol DetailGraphInteractorToPresenterProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func fecthData(_ model: ServiceResponse)
}

protocol DetailGraphPresenterToInteractorProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter : DetailGraphInteractorToPresenterProtocol? { get set }
    func fetchData()
}

protocol DetailGraphViewToPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view       : DetailGraphPresenterToViewProtocol? { get set }
    var interactor : DetailGraphPresenterToInteractorProtocol? { get set }
    var router     : DetailGraphPresenterToRouterProtocol? { get set }
    func didLoad()
    func fetchData()
}

protocol DetailGraphPresenterToRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    /*
     //Uncomment if view is based on navigation controller
     var navigation: UINavigationController? { get set }
     */
    func createDetailGraphScene() -> UIViewController
    var controller: DetailGraphView? { get set }
    func showNextView()
}




