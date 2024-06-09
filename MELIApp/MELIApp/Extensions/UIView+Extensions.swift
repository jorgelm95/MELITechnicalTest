//
//  UIView+Extensions.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit

extension UIView {
    func addConstraints(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            if let leading = leading {
                leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
            }
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            if let trailing = trailing {
                trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
            }
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            
            if let centerX = centerX {
                centerXAnchor.constraint(equalTo: centerX).isActive = true
            }
            
            if let centerY = centerY {
                centerYAnchor.constraint(equalTo: centerY).isActive = true
            }
        }
}
