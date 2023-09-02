//
//  APIClient.swift
//  NYTimes
//
//  Created by Елена Русских on 2023-09-02.
//

import Foundation

struct APIClient {
    enum Method {
      
        static let baseUrlString = "https://api.nytimes.com/svc"
        
        case emailed
        case shared
        case viewed
        
        var url: URL? {
            switch self {
            case .emailed:
                return URL(string: Method.baseUrlString)?.appendingPathComponent("emailed")
            case .shared:
                return URL(string: Method.baseUrlString)?.appendingPathComponent("shared")
            case .viewed:
                return URL(string: Method.baseUrlString)?.appendingPathComponent("viewed")
            }
        }
    }
}

