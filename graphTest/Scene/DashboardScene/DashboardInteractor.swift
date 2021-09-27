//
//  DashboardInteractor.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//  
//

import UIKit
import Foundation

/*
 Interactor: contains the business logic as specified by a use case.
 
 Bidirectionally interacts with the presenter to receive inputs, fetch data, perform complex calculations, the results of which are displayed to the user through the interactor. The Interactor can communicate with a Worker (the component responsible for fetching data from the network), based on the translated user input fed by the Interactor. In practice the Interactor can get data from a webservice.
 */

class DashboardInteractor: DashboardPresenterToInteractorProtocol {

    // MARK: Properties
    weak var presenter: DashboardInteractorToPresenterProtocol?

    func fetchData() {

    }
}

