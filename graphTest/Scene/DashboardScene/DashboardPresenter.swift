//
//  DashboardPresenter.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//  
//

import Foundation

/*
 Presenter: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
 
 Interacts directly with the view and the interactor. Responsible for taking user inputs from the view, and transferring them to the interactor. Presenter changes the type of the data, if the Interactor requires the data in a specific format. In practice the modules communicate through the presenters.
 */

class DashboardPresenter: DashboardViewToPresenterProtocol  {

    func fetchData() {
        interactor?.fetchData()
    }
    
    
    // MARK: Properties
    weak var view : DashboardPresenterToViewProtocol?
    var interactor: DashboardPresenterToInteractorProtocol?
    var router    : DashboardPresenterToRouterProtocol?
    
    func updateData(){
        
    }
    
    func didLoad() {
        
    }
    
    func showDetail() {
        router?.showDetail()
    }
    
}

extension DashboardPresenter: DashboardInteractorToPresenterProtocol {
    // TODO: implement presenter methods
    func fecthData(_ model: ServiceResponse) {
        view?.showData(model)
    }
}
