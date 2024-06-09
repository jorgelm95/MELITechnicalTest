//
//  BulletPointTableViewCell.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

class BulletPointTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: BulletPointTableViewCell.self)
    
    private struct Constants {
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let bulletImageSize: CGSize = CGSize(width: 8, height: 8)
        static let titleLAbelFontSize: CGFloat = 15
        static let bulletImageName = "circle.fill"
    }
    
    // MARK: - Private properties -
    
    private lazy var itemsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var bulletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.bulletImageName)
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleLAbelFontSize)
        label.textColor = .meliLighGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleLAbelFontSize)
        label.textColor = .meliLighGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - LifeCycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBulletImageView()
        setupItemsStack()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = .empty
    }
    
    // MARK: - Internal methods -
    
    func configure(title: String, value: String) {
        self.selectionStyle = .none
        titleLabel.text = title
        valueLabel.text = value
    }
    
    // MARK: - Private methods -
    
    private func setupBulletImageView() {
        contentView.addSubview(bulletImageView)
        bulletImageView.addConstraints(
            leading: contentView.leadingAnchor,
            centerY: contentView.centerYAnchor,
            paddingLeft: Constants.paddingLeft,
            width: Constants.bulletImageSize.width,
            height: Constants.bulletImageSize.height)
    }
    
    private func setupItemsStack() {
        itemsStack.addArrangedSubview(titleLabel)
        itemsStack.addArrangedSubview(valueLabel)
        
        contentView.addSubview(itemsStack)
        itemsStack.addConstraints(
            top: contentView.topAnchor,
            leading: bulletImageView.leadingAnchor,
            centerY: contentView.centerYAnchor,
            paddingLeft: Constants.paddingLeft)
    }
}
