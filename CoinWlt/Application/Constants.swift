//
//  Constants.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import UIKit

struct Constants {
    public struct UserDefaults {}
    
    public struct Api {
        #if DEBUG
            static let baseUrl = "http://www.amock.io/api/dbouzikas"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/429"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/429-wallets"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/429-histories"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/500"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/500-wallets"
//            static let baseUrl = "http://www.amock.io/api/dbouzikas/500-histories"
        #else
            static let baseUrl = "http://www.amock.io/api"
        #endif
    }
    
    public struct Animations {
        static let emptyResults = "empty-results"
        static let loader = "loader"
    }
    
    public struct Keys {}
    
    public struct Colors {}
    
    public struct ImageNames {}
    
    public struct QueryKeys {}
    
    public struct Fonts {}
}
