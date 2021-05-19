//
//  APICaller.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import Foundation

class CurrencyAPICaller {
    
    static let shared = CurrencyAPICaller()
    
    private struct Constants {
        static let apiKey = "E5CA3808-7556-4F7B-95C9-1ECA0E5AEDBE"
        static let endPoint = "https://rest-sandbox.coinapi.io/v1/assets/"
    }
    
    private init() {}
    public var currencyIcons: [currencyIcon] = []
    private var blockReady: ((Result<[cryptoCurrency], Error>)->Void)?
    
    //MARK: - Public
    
    public func getCryptoValue(
        completionHandler: @escaping (Result<[cryptoCurrency], Error>) -> Void
    ){
        guard !currencyIcons.isEmpty else {
            blockReady = completionHandler
            return
        }
        guard let url = URL(string: Constants.endPoint + "?apikey=" + Constants.apiKey) else {
            return
        }
        
        let taskData = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {   
                let currencies = try JSONDecoder().decode([cryptoCurrency].self, from: data)
                completionHandler(.success(currencies.sorted { (first, second) -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        taskData.resume()
    }
    
    public func getIcons() {
        guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/icons/55/?apikey=E5CA3808-7556-4F7B-95C9-1ECA0E5AEDBE") else {
            return
        } //uwrap
        
        //set a data task
        let taskData = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            } //get data, make sure exist
            
            do {
                
                self?.currencyIcons = try JSONDecoder().decode([currencyIcon].self, from: data)
                if let completionHandler = self?.blockReady {
                    self?.getCryptoValue(completionHandler: completionHandler)
                }
                
            }
            catch {
                print(error)
            }
        }
        taskData.resume() //start task
    }
}
