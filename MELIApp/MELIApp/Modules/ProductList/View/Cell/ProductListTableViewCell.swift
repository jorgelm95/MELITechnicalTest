//
//  ProductListTableViewCell.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit
import MELIAppDomain

final class ProductListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: ProductListTableViewCell.self)
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let secondaryItemsPaddingtop: CGFloat = 5
        static let imageViewCornerRadius: CGFloat = 10
        static let contentViewPaddingTop: CGFloat = 30
        static let titleLabelFontSize: CGFloat = 14
        static let priceLabelfontsize: CGFloat = 16
        static let secondaryItemsFontSize: CGFloat = 12
        static let productImageSize: CGSize = CGSize(width: 100, height: 100)
    }
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font =  UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        label.textColor = .meliLighGray
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: Constants.priceLabelfontsize)
        label.textColor = .black
        return label
    }()
    
    private lazy var shippingLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: Constants.secondaryItemsFontSize)
        label.textColor = .meliGreen
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: Constants.secondaryItemsFontSize)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupProductImageView()
        setupTitleLabel()
        setupTagsLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: ProductInformation) {
        self.selectionStyle = .none
        titleLabel.text = product.title
        priceLabel.text = product.price?.convertToString() ?? .empty
        shippingLabel.text = product.thumbnail
        ratingLabel.text = product.condition
        productImageView.downloadImage(from: product.thumbnail)
    }
    
    private func setupProductImageView() {
        contentView.addSubview(productImageView)
        productImageView.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            width: Constants.productImageSize.width,
            height: Constants.productImageSize.height)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.addConstraints(
            top: contentView.topAnchor,
            leading: productImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupTagsLabels() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(shippingLabel)
        contentView.addSubview(ratingLabel)
        
        priceLabel.addConstraints(
            top: titleLabel.bottomAnchor,
            leading: productImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.secondaryItemsPaddingtop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        shippingLabel.addConstraints(
            top: priceLabel.bottomAnchor,
            leading: productImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.secondaryItemsPaddingtop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        ratingLabel.addConstraints(
            top: shippingLabel.bottomAnchor,
            leading: productImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.secondaryItemsPaddingtop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
}
