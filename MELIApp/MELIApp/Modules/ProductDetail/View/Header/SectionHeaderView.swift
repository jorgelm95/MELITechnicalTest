//
//  SectionHeaderView.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = String(describing: SectionHeaderView.self)
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let priceFontSize: CGFloat = 20
        static let headerTextFontSize: CGFloat = 20
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.headerTextFontSize)
        label.textColor = .meliLighGray
        label.numberOfLines = 0
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingBottom: Constants.paddingBottom,
            paddingRight: Constants.paddingRight)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
