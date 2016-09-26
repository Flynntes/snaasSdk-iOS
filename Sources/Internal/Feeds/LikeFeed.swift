//
//  LikeFeed.swift
//  Tapglue
//
//  Created by Onur Akpolat on 29/07/16.
//  Copyright © 2016 Tapglue. All rights reserved.
//

import Foundation
import ObjectMapper

class LikeFeed: NullableFeed {
    var likes: [Like]?
    var users: [String: User]?
    var posts: [String: Post]?
    
    required init?(map: Map) {
        
    }
    
    required init() {
        self.likes = [Like]()
    }
    
    func mapping(map: Map) {
        likes <- map["likes"]
        users <- map["users"]
        posts <- map["post_map"]
    }
}
