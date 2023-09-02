//
//  APIService.swift
//  NYTimes
//
//  Created by Елена Русских on 18.11.2022.
//

import UIKit
import Alamofire
import Combine

class ApiService {
    
    static let shared  = ApiService()
    let baseUrl = "https://api.nytimes.com/svc"
    
    private init(){}
    
    func fetchData(type: String) -> AnyPublisher<[News], Error> {
        let path = "/mostpopular/v2/\(type)/30.json"
        let parameters: Parameters = [
            "api-key" : ApiKey().key
        ]
        
        let url = baseUrl+path
        
        return Future { promise in
            AF.request(url, method: .get, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let newsEnvelope = try JSONDecoder().decode(NewsEnvelope.self, from: data)
                        promise(.success(newsEnvelope.results))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
