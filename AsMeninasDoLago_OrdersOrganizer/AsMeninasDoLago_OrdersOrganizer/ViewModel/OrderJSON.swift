//
//  OrderJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

struct OrderJSON: Decodable, Hashable {
	var name: String?
	var totalValue: Double?
}
