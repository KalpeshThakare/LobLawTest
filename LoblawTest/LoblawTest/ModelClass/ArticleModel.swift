//
//  ArticleModel.swift
//  LoblawTest
//
//  Created by Kalpesh Thakare on 2020-08-31.
//  Copyright © 2020 Kalpesh Thakare. All rights reserved.
//

import Foundation

struct ArticleModel: Decodable {
    var data : ArticleData
}

struct ArticleData: Decodable {
    var children : [Articles]
}

struct Articles: Decodable {
    var data : ArticleDetails
}

struct ArticleDetails: Decodable {
    var title: String?
    var selftext: String?
    var thumbnail: String?
}
