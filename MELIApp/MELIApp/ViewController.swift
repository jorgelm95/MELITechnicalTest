//
//  ViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

class ViewController: UIViewController {

    
    private lazy var iconIMage: UIImageView = {
        let image = UIImage(named: "MeliIcon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setupIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func setupIcon() {
        view.addSubview(iconIMage)
        iconIMage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        iconIMage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        iconIMage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconIMage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

