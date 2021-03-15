//
//  RepositoryProtocol.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol Repository {
    associatedtype Model
    associatedtype T
    
    func getAll() -> T
    func results(completion: @escaping ([Model]) -> ()) -> T
    func error(completion: @escaping (Error) -> ()) -> T
}
