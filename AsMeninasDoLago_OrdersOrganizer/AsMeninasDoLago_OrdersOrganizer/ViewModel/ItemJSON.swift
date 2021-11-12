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




struct NewOrderItem: Decodable, Hashable {
    var item: ItemJSON
    var quantity: Int
    var comments: String?
}

struct Order: Decodable, Hashable {
    var name: String
    var items: [NewOrderItem]
    var total: Double
}
