//
//  Tapglue.swift
//  Tapglue
//
//  Created by John Nilsen on 6/27/16.
//  Copyright © 2016 Tapglue. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

public class Tapglue {
    
    var network: Network
    
    public init() {
        Router.configuration = Configuration()
        network = Network()
    }
    
    public func createUser(user: User) -> Observable<User> {
        return network.createUser(user)
    }
    
    public func loginUser(username: String, password: String) -> Observable<User> {
        return network.loginUser(username, password: password)
    }

    public func updateCurrentUser(user: User) -> Observable<User> {
        return network.updateCurrentUser(user)
    }

    public func refreshCurrentUser() -> Observable<User> {
        return network.refreshCurrentUser()
    }

    public func retrieveFollowers() -> Observable<[User]> {
        return network.retrieveFollowers()
    }
}