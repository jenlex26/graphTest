//
//  DashboardRouter.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//  
//

import Foundation
import UIKit

/*
 Router: contains navigation logic for describing which screens are shown in which order.
 
 Routes the App to the appropriate screen. The router has to have a direct reference to the viewcontroller, with the presenter acting as an intermediary between view and router.
 
 */

class DashboardRouter: DashboardPresenterToRouterProtocol {
    
    //Uncomment if view is based on navigation controller
    
    var navigation: UINavigationController?
    
    weak var controller: DashboardView?
    
    func createDashboardScene() -> UIViewController {
        
        /*
         Replace DashboardView to match Storyboard Id
         */
        
        let view = UIStoryboard.overFullScreen(type: .main,
                                               and: "DashboardView") as? DashboardView
        view?.title = "Dashboard"
        
        let presenter : DashboardViewToPresenterProtocol & DashboardInteractorToPresenterProtocol = DashboardPresenter()
        let interactor: DashboardPresenterToInteractorProtocol = DashboardInteractor()
        let router    : DashboardPresenterToRouterProtocol = DashboardRouter()
        
        
        //Uncomment if view is based on navigation controller
        
         navigation = UINavigationController(rootViewController: view!)
         router.navigation    = navigation
         
        router.controller    = controller
        
        view?.presenter      = presenter
        presenter.view       = view
        presenter.router     = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
//        return view!
        
        //Uncomment if view is based on navigation controller
        
         return navigation!
         
        
    }
    
    func showDetail(){
        let scene = DetailGraphRouter().createDetailGraphScene()
        navigation?.pushViewController(scene, animated: true)
    }
    
    func showNextView() {
        /*
         let scene = DashboardRouter().createDashboardScene()
         navigation?.pushViewController(scene, animated: true)
         */
    }
    
}
