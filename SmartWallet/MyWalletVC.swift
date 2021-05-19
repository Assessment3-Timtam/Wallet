//
//  WalletViewController.swift
//  SmartWallet
//
//  Created by Jun Liu.
//

import UIKit

let kMyWalletTBVCellID: String = "MyWalletTBVCellID"

class MyWalletVC: UIViewController {
// MARK: - Properties & Lazy Load
    private lazy var myCoinsListTBV: UITableView = {
        let table = UITableView()
        
        table.register(UINib(nibName: "MyWalletTBVCell", bundle: nil), forCellReuseIdentifier: kMyWalletTBVCellID)
        
        return table
    }()
    
    let myCoinsArr: Array<MyCoinModel>
    
    init(myCoinsArr: Array<MyCoinModel>) {
        self.myCoinsArr = myCoinsArr
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        initial()
    }
}

// MARK: - Private & Tool Methods
extension MyWalletVC {
    private func setupViews() -> Void {
        title = "Wallet"
        view.backgroundColor = .black
        
        myCoinsListTBV.frame = view.bounds
        view.addSubview(myCoinsListTBV)
    }
    
    private func setupBindings() -> Void {
        myCoinsListTBV.delegate = self
        myCoinsListTBV.dataSource = self
    }
    
    private func initial() -> Void {
        
    }
}

// MARK: - UITableViewDataSource
extension MyWalletVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCoinsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyWalletTBVCell = tableView.dequeueReusableCell(withIdentifier: kMyWalletTBVCellID, for: indexPath) as! MyWalletTBVCell
        
        // config
        let model: MyCoinModel = myCoinsArr[indexPath.row]
        cell.setModel(model: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MyWalletVC : UITableViewDelegate {
    
}


