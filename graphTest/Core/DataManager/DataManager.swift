//
//  DataManager.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//

import Foundation
import Alamofire

class DataManager {
    func fetchData<T: Decodable>(responseModel: T.Type, path: String, method: HTTPMethod, parameters:[String: Any]? = nil, headers: HTTPHeaders? = nil, completionHandler: @escaping (Result<Decodable, Error>) -> Void) {
        AF.request(path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(responseModel, from: data)
                    completionHandler(.success(response))
                }
                catch {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let failure):
                completionHandler(.failure(failure))
                break
            }
        }
    }
}

