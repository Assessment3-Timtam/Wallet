//
//  APIModel.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import Foundation

struct cryptoCurrency: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
} //for JOSON decode data

struct currencyIcon: Codable {
    let asset_id: String
    let url: String
}
