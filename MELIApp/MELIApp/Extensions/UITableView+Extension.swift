//
//  UITableView+Extension.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import UIKit

extension UITableView {
    
    func setEmptyState(text: String, image: String) {
        let emptyState = EmptyStateView(text: text, image: image, frame: CGRect(
            x: 0,
            y: 0,
            width: self.bounds.size.width,
            height: self.bounds.size.height))
        self.backgroundView = emptyState
    }
}
