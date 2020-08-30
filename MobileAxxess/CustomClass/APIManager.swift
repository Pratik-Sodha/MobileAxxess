//
//  APIManager.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

    //---------------------------------------------------------
    //MARK:-
    private let baseURL : URL = URL(string: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/")!
    
    //---------------------------------------------------------
    //MARK:-
    static let  manager : APIManager = APIManager()
    
    //---------------------------------------------------------
    //MARK:-
    typealias SuccessCompletion = ((Data) -> Void)?
    typealias FailureCompletion = ((Error) -> Void)?

    //---------------------------------------------------------
    //MARK:-
    @discardableResult
    func getAPI(method : String,
                parameters : [String : Any] = [:],
                successCompletion : SuccessCompletion,
                failureCompletion : FailureCompletion) -> DataRequest {
        
        let url = baseURL.appendingPathComponent(method)
        return AF.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.queryString).responseJSON { [weak self] (response) in
                            
                            self?.parseRawData(response: response,
                                               successCompletion: successCompletion,
                                               failureCompletion: failureCompletion)
                            
        }
    }
    
}

//---------------------------------------------------------
//MARK:-
private extension APIManager {
    
    func parseRawData(response : AFDataResponse<Any>,
                        successCompletion : SuccessCompletion,
                        failureCompletion : FailureCompletion) {

        switch response.result {
        case .success:
            
            guard let data = response.data else {
                failureCompletion?(NSError(domain: "Something wrong.",
                                           code: 0,
                                           userInfo: nil))
                return
            }
  
            successCompletion?(data)
            break
        case let .failure(error):
            failureCompletion?(error)
            break
        }

    }
    
}
