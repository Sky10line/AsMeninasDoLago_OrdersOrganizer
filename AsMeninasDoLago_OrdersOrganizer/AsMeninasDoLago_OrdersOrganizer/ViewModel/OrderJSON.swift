//
//  OrderJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

struct OrderJSON: Decodable, Hashable {
    var id: Int?
    var name: String
    var items: [ItemInfo]
    var totalValue: Double
}

struct ItemInfo: Decodable, Hashable {
    var nome: String
    var quantidade: Int
    var preco: Double
    var observacoes: String
    var nomeImagem: String
}

struct OrderItem: Decodable, Hashable {
    var item: ItemJSON
    var quantity: Int
    var comments: String?
}

let emptyOrder = OrderJSON(name: "", items: [], totalValue: 0)


