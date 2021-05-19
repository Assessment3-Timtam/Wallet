//
//  ViewController.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func currencyRateBtnClicked(_ sender: Any) {

        let vc = CryptoVC()

        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func myWalletBtnClicked(_ sender: Any) {

        let vc = MyWalletVC(myCoinsArr: myCoionsArr)

        navigationController?.pushViewController(vc, animated: true)
    }
}

