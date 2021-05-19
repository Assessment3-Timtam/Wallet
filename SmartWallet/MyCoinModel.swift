//
//  MyCoinModel.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

class MyCoinModel: NSObject {
    
    let coinName: String // coin name
    let unitPrice: String 
    var amount: String
    
//    var totalAmount: Double {
//        return ((Double(amount) ?? 0) * (Double(unitPrice) ?? 0))
//    }
    
    init(coinName: String, unitPrice: String, amount: String) {
        self.coinName = coinName;
        self.unitPrice = unitPrice;
        self.amount = amount
        super.init()
    }
}
