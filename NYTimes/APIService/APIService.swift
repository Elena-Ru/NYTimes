//
//  APIService.swift
//  NYTimes
//
//  Created by Елена Русских on 18.11.2022.
//

import UIKit
import Alamofire

class ApiService {
    
    static let shared  = ApiService()
    let baseUrl = "https://api.nytimes.com/svc"
    
    private init(){}
    
    func fetchData(type: String, completion: @escaping ([News]?) -> Void) {
        let path = "/mostpopular/v2/\(type)/30.json"
        print(path)
        let parameters: Parameters = [
            "api-key" : ApiKey().key
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else {
                completion(nil)
                return
            }
            let news = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
            news == nil ? completion(nil) : completion(news?.results)
        }
    }
}
                                                                                  
                                                        
                                             
                                                                                                                                                                             
