//
//  String+Extensions.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import Foundation

extension String {
    
    static var empty: String = ""
    var isNotEmpty: Bool {
        return  self != .empty
    }
}
