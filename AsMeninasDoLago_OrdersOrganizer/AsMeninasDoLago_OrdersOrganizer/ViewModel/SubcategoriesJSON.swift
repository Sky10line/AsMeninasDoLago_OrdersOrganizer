//
//  SubcategoriesJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 26/10/21.
//

import Foundation

struct SubcategoriesJSON: Decodable, Hashable  {
	var name: String?
	var items: [ItemJSON]?
}
