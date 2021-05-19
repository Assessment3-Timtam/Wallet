//
//  CryptoCoinsViewModel.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import Foundation

class CryptoCoinsVM: NSObject {
    
    var crytoCoinsModels: [CryptoCoinModel]?
    
    func loadModels(completion: @escaping () -> Void) -> Void {
        CurrencyAPICaller.shared.getCryptoValue { [weak self] result in
            switch result {
            case.success(let APImodels):
                self?.crytoCoinsModels = APImodels.compactMap({ APImodel in
                    let price = APImodel.price_usd ?? 0
                    let formatter = ToolsManager.shared.numFormatter
                    let stringOfPrice = formatter.string(from: NSNumber(value: price))
                    
                    let getIcon = URL(string: CurrencyAPICaller.shared.currencyIcons.filter({currencyIcon in currencyIcon.asset_id == APImodel.asset_id}).first?.url ?? "")
                    
                    return CryptoCoinModel(
                        cName: APImodel.name ?? "N/A",
                        cSymbol: APImodel.asset_id,
                        cPrice: stringOfPrice ?? "N/A",
                        getIcon: getIcon
                    )
                })
                DispatchQueue.main.async {
                    completion()
                }
            case.failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
