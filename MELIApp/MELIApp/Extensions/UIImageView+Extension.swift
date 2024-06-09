//
//  UIImageView+Extension.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
    
}
