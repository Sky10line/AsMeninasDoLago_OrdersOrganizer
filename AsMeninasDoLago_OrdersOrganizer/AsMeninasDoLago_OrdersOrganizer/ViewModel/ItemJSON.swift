//
//  ItemJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 24/10/21.
//

import Foundation

struct ItemJSON: Decodable, Hashable {
	var name: String?
	var price: Double?
	var image: String?
}


struct ItemJSON2: Decodable, Hashable {
    var name: String
    var price: Double
    var image: String?
}
