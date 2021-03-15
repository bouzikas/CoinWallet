# Coin Wallet

#### Pods
Pod install needed in order to run the project. The pods used are:
* Alamofire
* RxSwift
* RxCocoa
* lottie-ios
* SkeletonView

#### Testing
For testing various errors please refer to `CoinWlt/Application/Constants.swift` and uncomment the one you want to test.
The first:
* `http://www.amock.io/api/dbouzikas` returns `200 OK` for both wallets and histories.
* `http://www.amock.io/api/dbouzikas/429` returns `429` response for both.
* `http://www.amock.io/api/dbouzikas/429-wallets` returns `429` wallets and `200 OK` for histories.
* `http://www.amock.io/api/dbouzikas/429-histories` returns `429` histories and `200 OK` for wallets.
* `http://www.amock.io/api/dbouzikas/500` returns `500` response for both.
* `http://www.amock.io/api/dbouzikas/500-wallets`  returns `500` wallets and `200 OK` for histories.
* `http://www.amock.io/api/dbouzikas/500-histories`  returns `500` histories and `200 OK` for wallets.

*Note: Please be sure to have `http://www.amock.io/api/dbouzikas` when running the CoinWltTests suite.*
