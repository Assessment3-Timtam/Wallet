//
//  CryptoTableViewCell.swift
//  SmartWallet
//
//  Created by Jun Liu 11586310.
//

import UIKit

class CryptoTBVCell: UITableViewCell {
    static let id = "CryptoTableViewCell"
    
// MARK: - Properties
    private let cNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let cSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let cPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let cIconImage: UIImageView = {
        let imageVeiw = UIImageView()
        imageVeiw.contentMode = .scaleAspectFit
        return imageVeiw
    }()
    
// MARK: - initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cNameLabel)
        contentView.addSubview(cSymbolLabel)
        contentView.addSubview(cPriceLabel)
        contentView.addSubview(cIconImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize: CGFloat = contentView.frame.size.height/1.1
        cIconImage.frame = CGRect(x: 20, y: (contentView.frame.size.height-iconSize)/2, width: iconSize, height: iconSize)
        
        cNameLabel.sizeToFit()
        cPriceLabel.sizeToFit()
        cSymbolLabel.sizeToFit()
        
        cNameLabel.frame = CGRect(x: 30 + iconSize, y: 0, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        
        cSymbolLabel.frame = CGRect(x: 30 + iconSize, y: contentView.frame.size.height/2, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        
        cPriceLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: (contentView.frame.size.width/2)-15, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cIconImage.image = nil
        cNameLabel.text = nil
        cPriceLabel.text = nil
        cSymbolLabel.text = nil
    }
    
// MARK: - Public
    func config(with cryptoCoinModel: CryptoCoinModel, completion: @escaping (_ iconImage: UIImage) -> Void) {
        cNameLabel.text = cryptoCoinModel.cName
        cSymbolLabel.text = cryptoCoinModel.cSymbol
        cPriceLabel.text = cryptoCoinModel.cPrice
        
        if let iconImage = cryptoCoinModel.iconImage {
            cIconImage.image = iconImage
            return
        }
        
        if let data = cryptoCoinModel.iconImageData{
            cIconImage.image = UIImage(data: data)
        }
        else if let iconImageUrl = cryptoCoinModel.getIcon {
            let imageDataTask = URLSession.shared.dataTask(with: iconImageUrl) { [weak self] data, _, _ in
                if let data = data {
                    cryptoCoinModel.iconImageData = data
                    DispatchQueue.main.async {
                        self?.cIconImage.image = UIImage(data: data)
                    }
                }
            }
            imageDataTask.resume()
        }
    }
}
