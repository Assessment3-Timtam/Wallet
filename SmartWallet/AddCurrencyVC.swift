//
//  AddCurrencyViewController.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

var myCoins: Dictionary<String, String> = [:]

var myCoionsArr: Array<MyCoinModel> = []

class AddCurrencyVC: UIViewController {
// MARK: - initializer
    private let selectedName: String
    private let selectedPrice: String
    
    init(selectedName: String, selectedPrice: String) {
        self.selectedName = selectedName
        self.selectedPrice = selectedPrice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Properties & Lazy Load
    private lazy var field: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.placeholder = "0.00"
        field.textColor = .black
        field.backgroundColor = .white
        return field
    }()

// MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
}

// MARK: - Private & Tool Methods
extension AddCurrencyVC {
    private func setViews() -> Void {
        view.backgroundColor = .gray
        title = "Add Currency"
        
        let label = UILabel(frame: view.bounds)
        view.addSubview(label)
        label.textAlignment = .center
        label.numberOfLines = -1
        label.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: 100)
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = selectedName + " " + selectedPrice
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        field.frame = CGRect(x: 20, y: 300, width: view.frame.size.width-40, height: 50)
        view.addSubview(field)
        field.becomeFirstResponder()
    }
}

// MARK: - Actions
extension AddCurrencyVC {
    @objc private func tappedButton() {

        // get data
        let amount: String = field.text!
        let unitPrice: String = selectedPrice
        let coinName: String = selectedName
        
        // package model
        let model: MyCoinModel = MyCoinModel(coinName: coinName, unitPrice: unitPrice, amount: amount)
        
        // Add to global array
        var isCoinExisted: Bool = false
        var index: Int = -1
        for coin in myCoionsArr {
            if (coin.coinName == model.coinName) {
                // The same coin already exists
                isCoinExisted = true
                index = myCoionsArr.firstIndex(of: coin)!
                break
            }
        }
        
        if (isCoinExisted == true) {
            // Update amount if it exists
            let preAmount = Double(myCoionsArr[index].amount)!
            let curAmount = Double(model.amount)!
            let amountUpdated = preAmount + curAmount
            myCoionsArr[index].amount = String(amountUpdated)
        } else {
            // Add if it doesn't exist
            myCoionsArr.append(model)
        }
        
        // 3. Instantiate ViewController -> present
        let vc = MyWalletVC(myCoinsArr: myCoionsArr)
        present(vc, animated: true) {
            self.field.text = ""
        }
    }
}
