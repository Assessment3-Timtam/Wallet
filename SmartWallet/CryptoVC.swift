//
//  CryptoViewController.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

//API Caller
//UI  to show different crypto
//MVVM

class CryptoVC: UIViewController {
    
// MARK: - Properties
    private lazy var cryptoTableView: UITableView = {
        let cryptoTableView = UITableView(frame: .zero, style: .grouped)
        cryptoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "putongcell")
        cryptoTableView.register(CryptoTBVCell.self, forCellReuseIdentifier: CryptoTBVCell.id)
        return cryptoTableView
    }()
    
    // View Model provide data
    private lazy var cryptoCoinsVM: CryptoCoinsVM = CryptoCoinsVM()
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setBindings()
        initial()
    }
    
// MARK: - Private & Tool Methods
    // load views & make sure views' position and size
    private func setViews() -> Void {
        title = "Crypto Currency Rate"
        view.addSubview(cryptoTableView)
        cryptoTableView.frame = view.bounds
    }
    
    // set binding data & agency
    private func setBindings() -> Void {
        cryptoTableView.dataSource = self
        cryptoTableView.delegate = self
    }
    
    // Do some initial operations, send some network requests and data
    private func initial() -> Void {
        cryptoCoinsVM.loadModels { () -> Void in
            self.cryptoTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension CryptoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoCoinsVM.crytoCoinsModels?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if nil == cryptoCoinsVM.crytoCoinsModels || cryptoCoinsVM.crytoCoinsModels?.count ?? 0 == 0 {
            // Can't get data, show prompt cell
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "putongcell", for: indexPath)
            cell.detailTextLabel?.text = " "
            cell.detailTextLabel?.textColor = UIColor.black
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            // Get the data, display cell
            let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTBVCell.id, for: indexPath) as! CryptoTBVCell

            // config
            let model : CryptoCoinModel = cryptoCoinsVM.crytoCoinsModels![indexPath.row]
            cell.config(with: model) { (icomImage: UIImage) -> Void in
                self.cryptoCoinsVM.crytoCoinsModels![indexPath.row].iconImage = icomImage
            }
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension CryptoVC: UITableViewDelegate {
    
    // Click on the proxy method of cell response
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 1. Get data model
        let model: CryptoCoinModel = cryptoCoinsVM.crytoCoinsModels![indexPath.row]
        let selName: String = model.cName
        let selPrice: String = model.cPrice
        let index: Int = indexPath.row
        // 2. Instantiate the ViewController that requires preparation
        let vc = AddCurrencyVC(selectedName: selName, selectedPrice: selPrice)
        
        // 3. present ViewController
        present(vc, animated: true) {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
