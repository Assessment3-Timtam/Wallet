//
//  MyWalletTBVCell.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

class MyWalletTBVCell: UITableViewCell {

    @IBOutlet weak var mwCoinNameLbl: UILabel!
    @IBOutlet weak var mwUnitPriceLbl: UILabel!
    @IBOutlet weak var mwCoinAmountLbl: UILabel!
//    @IBOutlet weak var mwTotalAmoutLbl: UILabel!
    
    func setModel(model: MyCoinModel) -> Void {
        mwCoinNameLbl.text = model.coinName
        mwUnitPriceLbl.text = model.unitPrice
        mwCoinAmountLbl.text = model.amount
//        mwTotalAmoutLbl.text = String(model.totalAmount)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
