//
//  ItemJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 24/10/21.
//

import Foundation

struct ItemJSON: Decodable, Hashable {
    var name: String
    var price: Double
    var image: String?
    var category: String
    var subcategory: String
}
