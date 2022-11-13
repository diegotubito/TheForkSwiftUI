//
//  String+Extension.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import Foundation

extension String {
    var toImageData: Data? {
        NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) as? Data
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
