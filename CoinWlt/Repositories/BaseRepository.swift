//
//  BaseRepository.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation
import RxSwift
import RxCocoa

public class DataSource<T> {
    public func getAll() throws -> [T] { return [] }
}

public class BaseRepository<Model>: Repository {
    var remoteDataSource: DataSource<Model>!
    var localDataSource: DataSource<Model>!

    private let disposeBag = DisposeBag()
    
    private let resultSet = BehaviorRelay<[Model]?>(value: nil)
    private let resultError = BehaviorRelay<Error?>(value: nil)

    /// A generic wrapper to get all records of the corresponding datasource
    ///
    /// - Returns: a reference of `BaseRepository`
    func getAll() -> BaseRepository {

        func local() {
            /// here we can call our local data source to retrieve
            /// the data, first we need to implement our local db logic
            /// example call:
            /// self.resultSet.value = try localDataSource.getAll()
        }

        func remote() {
            /// network retrieval should not be in main thread
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let results = try self.remoteDataSource.getAll()
                    // observable values should be update within the
                    // main thread, cause might be connected with UI
                    DispatchQueue.main.async {
                        self.resultSet.accept(results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.resultError.accept(error)
                    }
                }
            }
        }

        /// first we load the local
        local()

        /// then the remote
        remote()

        return self
    }

    /// Subscribes to watch for changes in the resultSet
    ///
    /// - Parameter completion: the completion to execute when a change is occurred
    /// - Returns: a reference of `BaseRepository`
    func results(completion: @escaping ([Model]) -> ()) -> BaseRepository {
        resultSet.asObservable()
        .subscribe(onNext: { results in
            guard let results = results else { return }
            completion(results)
        })
        .disposed(by: disposeBag)

        return self
    }

    /// Subscribes to watch for changes in the resultError
    ///
    /// - Parameter completion: the callback to execute when an error is occurred
    /// - Returns: a reference of `BaseRepository`
    func error(completion: @escaping (Error) -> ()) -> BaseRepository {
        resultError.asObservable()
        .subscribe(onNext: { error in
            guard let error = error else { return }
            completion(error)
        })
        .disposed(by: disposeBag)

        return self
    }
}
