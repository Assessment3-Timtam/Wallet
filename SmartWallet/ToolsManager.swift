//
//  ToolsManager.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

class ToolsManager: NSObject {
    
    static let shared: ToolsManager = ToolsManager()
    
    lazy var numFormatter: NumberFormatter = {
        let numFormat = NumberFormatter()
        numFormat.locale = .current
        numFormat.allowsFloats = true
        numFormat.numberStyle = .currency
        numFormat.formatterBehavior = .default

        return numFormat
    }()
}
