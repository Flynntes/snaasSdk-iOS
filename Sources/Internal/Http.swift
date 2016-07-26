    //
//  Http.swift
//  Tapglue
//
//  Created by John Nilsen on 7/8/16.
//  Copyright © 2016 Tapglue. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

class Http {
    func execute<T:Mappable>(request: NSMutableURLRequest) -> Observable<T> {
        return Observable.create {observer in
            Alamofire.request(request)
                .validate()
                .debugLog()
                .responseObject { (response: Response<T, NSError>) in
                    print(response.result.value?.toJSONString())
                    switch(response.result) {
                    case .Success(let value):
                        print(value)
                        observer.on(.Next(value))
                        observer.on(.Completed)
                    case .Failure(let error):
                        self.handleError(response.data, onObserver: observer, withDefaultError:error)
                    }
                }
            return NopDisposable.instance
        }
    }
    
    func execute(request:NSMutableURLRequest) -> Observable<Void> {
        return Observable.create {observer in
            Alamofire.request(request)
                .validate()
                .debugLog()
                .responseJSON { response in
                    switch(response.result) {
                    case .Success:
                        observer.on(.Completed)
                    case .Failure(let error):
                        self.handleError(response.data, onObserver: observer, withDefaultError: error)
                    }
            }
            return NopDisposable.instance
        }
    }

    private func handleError<T>(data: NSData?, onObserver observer: AnyObserver<T>,
                                withDefaultError error: NSError) {
        if let data = data {
            let json = String(data: data, encoding: NSUTF8StringEncoding)!
            if let errorFeed = Mapper<ErrorFeed>().map(json) {
                let tapglueErrors = errorFeed.errors!
                observer.on(.Error(tapglueErrors[0]))
            } else {
                observer.on(.Error(error))
            }
        }
    }
}