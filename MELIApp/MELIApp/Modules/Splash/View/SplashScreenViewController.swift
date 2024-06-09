//
//  SplashScreenViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    
    struct Constanst {
        static let splashIcon: String = "MeliIcon"
        static let splashIconSize: CGSize = CGSize(width: 150, height: 150)
    }
    
    // MARK: - private Properties -
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var iconIMage: UIImageView = {
        let image = UIImage(named: Constanst.splashIcon)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setupIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - private methods -
    
    private func setupIcon() {
        view.addSubview(iconIMage)
        
        iconIMage.addConstraints(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            width: Constanst.splashIconSize.width,
            height: Constanst.splashIconSize.height)
    }
}
