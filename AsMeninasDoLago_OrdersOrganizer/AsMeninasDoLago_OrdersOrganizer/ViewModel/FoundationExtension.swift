//
//  FoundationExtension.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

extension Double {
	func asCurrencyBR() -> String? {
		let formatter = NumberFormatter()
		formatter.locale = Locale(identifier: "pt_br")
		formatter.numberStyle = .currency
		
		if let total = formatter.string(from: self as NSNumber) {
			return total
		}
		
		return nil
	}
}
