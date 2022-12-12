//
//  FakeRepositoryType.swift
//  Trinap
//
//  Created by 김세영 on 2022/12/12.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

protocol FakeRepositoryType {
    
    var isSucceedCase: Bool { get }
    
    init(isSucceedCase: Bool)
    
    func execute<Value>(successValue: Value, error: Error) -> Observable<Value>
}

extension FakeRepositoryType {
    
    func execute<Value>(successValue: Value, error: Error = FakeError.unknown) -> Observable<Value> {
        return .create { observer in
            if isSucceedCase {
                observer.onNext(successValue)
            } else {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}

extension String {
    
    static var random: String {
        let pool = "abcdefghijklmnopqrstuvwxyz"
        var random = ""
        
        for _ in 0..<Int.random(in: 10...100) {
            random.append(pool.randomElement() ?? "?")
        }
        
        return random
    }
}
