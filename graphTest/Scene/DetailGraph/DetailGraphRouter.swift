//
//  DetailGraphRouter.swift
//  graphTest
//
//  Created by Javier Hernandez on 24/09/21.
//  
//

import Foundation
import UIKit

/*
 Router: contains navigation logic for describing which screens are shown in which order.
 
 Routes the App to the appropriate screen. The router has to have a direct reference to the viewcontroller, with the presenter acting as an intermediary between view and router.
 
 */

class DetailGraphRouter: DetailGraphPresenterToRouterProtocol {
    
    //Uncomment if view is based on navigation controller
    /*
    var navigation: UINavigationController?
    */
    weak var controller: DetailGraphView?
    
    
    func createDetailGraphScene() -> UIViewController {
        
        /*
         Replace DetailGraphView to match Storyboard Id
         */
        
        let view = UIStoryboard.overFullScreen(type: .detailGraph,
                                               and: "DetailGraphView") as? DetailGraphView
        view?.title = "DetailGraphView"
        
        let presenter : DetailGraphViewToPresenterProtocol & DetailGraphInteractorToPresenterProtocol = DetailGraphPresenter()
        let interactor: DetailGraphPresenterToInteractorProtocol = DetailGraphInteractor()
        let router    : DetailGraphPresenterToRouterProtocol = DetailGraphRouter()
        
        
        //Uncomment if view is based on navigation controller
        /*
         navigation = UINavigationController(rootViewController: view!)
         router.navigation    = navigation
         */
        router.controller    = controller
        
        view?.presenter      = presenter
        presenter.view       = view
        presenter.router     = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view!
        
        //Uncomment if view is based on navigation controller
        /*
         return navigation!
         */
        
    }
    
    
    func showNextView() {
        /*
         let scene = DetailGraphRouter().createDetailGraphScene()
         navigation?.pushViewController(scene, animated: true)
         */
    }
    
}
