//
//  News.swift
//  NYTimes
//
//  Created by Елена Русских on 18.11.2022.
//

import Foundation

struct NewsEnvelope: Decodable {
    let status, copyright: String?
    let numResults: Int?
    let results: [News]
    
    enum CodingKeys: String, CodingKey {
          case status, copyright
          case numResults = "num_results"
          case results
      }
}

struct News: Decodable {
    var url: String? = ""
    var id: Int? = 0
    var title: String? = ""
    var abstract: String? = ""
    var media: [Media]? = nil
    init(){}
}

struct Media: Decodable {
    var mediaMetadata: [MediaMetadatum]? = nil

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}
struct MediaMetadatum: Decodable {
    var url: String? = ""
    var image: Data? = nil
    var height: Int? = 0
    var width: Int? = 0
    }
