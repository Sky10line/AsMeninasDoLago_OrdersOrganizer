//
//  OrderJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

//struct OrderJSON: Decodable, Hashable {
//	var name: String?
//	var totalValue: Double?
//}






struct OrderJSON2: Decodable, Hashable {
    var name: String
    var items: [OrderItem]
    var totalValue: Double
}


struct OrderItem: Decodable, Hashable {
    var item: ItemJSON2
    var quantity: Int
    var comments: String?
}


// MARK: - Dummy Data

let dummyCalabresa = ItemJSON2(name: "Calabresa com queijo e vinagrete", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
let dummyCarneLouca = ItemJSON2(name: "Carne Louca", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
let dummyBolinha = ItemJSON2(name: "Bolinhos de 3 queijos do porpeta", price: 26, image: "LanchePlaceHolder", category: "sanduiche", subcategory: "Lanches")

let dummyItens1 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil)]
let dummyOrder1 = OrderJSON2(name: "Carol", items: dummyItens1, totalValue: 26)


let dummyItens2 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil), OrderItem(item: dummyBolinha, quantity: 5, comments: nil)]
let dummyOrder2 = OrderJSON2(name: "Rodrigo", items: dummyItens2, totalValue: 26)


let dummyCollection = [dummyOrder1, dummyOrder2]


let emptyOrder = OrderJSON2(name: "", items: [], totalValue: 0)
