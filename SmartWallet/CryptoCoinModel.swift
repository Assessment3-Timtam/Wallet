//
//  File.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import Foundation
import UIKit

class CryptoCoinModel {
    let cName: String
    let cSymbol: String
    let cPrice: String
    let getIcon: URL?
    var iconImageData: Data?
    var iconImage: UIImage?
    
    init(cName: String, cSymbol: String, cPrice: String, getIcon: URL?) {
        self.cName = cName
        self.cSymbol = cSymbol
        self.cPrice = cPrice
        self.getIcon = getIcon
    }
}
