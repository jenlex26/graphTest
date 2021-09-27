//
//  DetailGraphInteractor.swift
//  graphTest
//
//  Created by Javier Hernandez on 24/09/21.
//  
//

import UIKit
import Foundation

/*
 Interactor: contains the business logic as specified by a use case.
 
 Bidirectionally interacts with the presenter to receive inputs, fetch data, perform complex calculations, the results of which are displayed to the user through the interactor. The Interactor can communicate with a Worker (the component responsible for fetching data from the network), based on the translated user input fed by the Interactor. In practice the Interactor can get data from a webservice.
 */

class DetailGraphInteractor: DetailGraphPresenterToInteractorProtocol {

    // MARK: Properties
    weak var presenter: DetailGraphInteractorToPresenterProtocol?
    let urlService = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
    
    func fetchData() {
        DataManager().fetchData(responseModel: ServiceResponse.self, path: urlService, method: .post) { [weak self] result in
            switch result {
            case .success(let model):
                debugPrint(model as! ServiceResponse)
                self?.presenter?.fecthData(model as! ServiceResponse)
            case .failure(let fail):
                print(fail)
            }
        }
    }

}

