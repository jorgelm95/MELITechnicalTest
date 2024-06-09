//
//  ProductDetailTableViewCell.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

final class ProductDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: ProductDetailTableViewCell.self)
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let priceFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 16
        static let productImageHeight: CGFloat = 200
        static let buttonCornerRadius: CGFloat = 10
        static let buttonHeight: CGFloat = 50.0
        static let buyNowPaddingTop: CGFloat = 20.0
        static let addToCardPaddingTop: CGFloat = 5.0
        static let alternativeTextsFontSize: CGFloat = 14
    }
    
    // MARK: - Private properties -
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = UIColor.meliLighGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.alternativeTextsFontSize)
        label.textColor = UIColor.meliGreen
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.priceFontSize)
        label.textColor = .meliGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var availableCuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.alternativeTextsFontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.alternativeTextsFontSize)
        label.textColor = .meliGreen
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Compar Ahora", for: .normal)
        button.backgroundColor = .meliBlue
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lightBlueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Agregar al carrito", for: .normal)
        button.setTitleColor(.meliBlue, for: .normal)
        button.backgroundColor = .meliLighBlue
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productTitle)
        contentView.addSubview(productImageView)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(availableCuantityLabel)
        contentView.addSubview(sellerNameLabel)
        contentView.addSubview(blueButton)
        contentView.addSubview(lightBlueButton)
        
        productTitle.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        productImageView.addConstraints(
            top: productTitle.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 5.0,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            height: Constants.productImageHeight)
        
        priceLabel.addConstraints(
            top: productImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        availableCuantityLabel.addConstraints(
            top: priceLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        sellerNameLabel.addConstraints(
            top: availableCuantityLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        blueButton.addConstraints(
            top: sellerNameLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.buyNowPaddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            height: Constants.buttonHeight)
        
        lightBlueButton.addConstraints(
            top: blueButton.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.addToCardPaddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            height: Constants.buttonHeight)
    }
    
    // MARK: - LifyCicle -
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productTitle.text = .empty
        priceLabel.text = .empty
        availableCuantityLabel.text = .empty
        sellerNameLabel.text = .empty
    }
    
    // MARK: - Configuration -
    
    func configure(
        title: String,
        imageUrl: String,
        price: String,
        availableCuantity: String,
        sellerName: String) {
            self.selectionStyle = .none
            productTitle.text = title
            productImageView.downloadImage(from: imageUrl)
            priceLabel.text = "$ \(price)"
            availableCuantityLabel.text = "Disponible en tienda \(availableCuantity)"
            sellerNameLabel.text = sellerName
    }
}

