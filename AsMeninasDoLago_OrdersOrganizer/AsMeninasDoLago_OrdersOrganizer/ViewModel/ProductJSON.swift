//
//  ProductJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Felipe Ferreira on 14/10/21.
//

import Foundation

struct ProductJSON: Decodable, Hashable {
    var name: String?
    var price: Double?
}
