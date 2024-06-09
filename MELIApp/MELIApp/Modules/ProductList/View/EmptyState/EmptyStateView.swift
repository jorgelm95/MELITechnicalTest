//
//  EmptyStateView.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import UIKit

final class EmptyStateView: UIView {
    
    private struct Constants {
        static let paddingTop: CGFloat = 20
        static let paddingLeft: CGFloat = 20
        static let paddingRight: CGFloat = 20
        static let imageSize: CGSize = CGSize(width: 100, height: 100)
        static let animationDuration: Double = 2.0
        static let animationDelay: Double = 0
    }
    
    // MARK: - Private properties -
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .meliLighGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Internal properties -
    
    var text: String = .empty
    var image: String = .empty
    
    // MARK: - Lifecycle -
    
    init(text: String, image: String, frame: CGRect) {
        super.init(frame: frame)
        self.text = text
        self.image = image
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - private Methods -
    
    private func setupView() {
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.image = UIImage(systemName: image)
        imageView.addConstraints(
            centerX: centerXAnchor,
            centerY: centerYAnchor,
            width: Constants.imageSize.width,
            height: Constants.imageSize.height)
        
        textLabel.text = text
        textLabel.addConstraints(
            top: imageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            centerX: centerXAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            width: Constants.imageSize.width,
            height: Constants.imageSize.height)
        
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: Constants.animationDelay,
            options: [.repeat, .autoreverse], animations: {
                
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi / 4)
            }, completion: nil)
    }
}
