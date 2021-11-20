//
//  OrderJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

struct OrderJSON: Decodable, Hashable {
    var name: String
    var items: [OrderItem]
    var totalValue: Double
}


// MARK: - OrderJSON2
struct OrderJSON2: Codable {
    let nome: String
    let total: Int
    let items: [Itemm]

    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
        case total = "Total"
        case items = "Items"
    }
}

// MARK: - Item
struct Itemm: Codable {
    let nome: String
    let quantidade, preco: Int
    let observacoes: String

    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
        case quantidade = "Quantidade"
        case preco = "Preco"
        case observacoes = "Observacoes"
    }
}



struct OrderItem: Decodable, Hashable {
    var item: ItemJSON
    var quantity: Int
    var comments: String?
}


// MARK: - Dummy Data

//let dummyCalabresa = ItemJSON(name: "Calabresa com queijo e vinagrete", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
//let dummyCarneLouca = ItemJSON(name: "Carne Louca", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
//let dummyBolinha = ItemJSON(name: "Bolinhos de 3 queijos do porpeta", price: 26, image: "LanchePlaceHolder", category: "sanduiche", subcategory: "Lanches")

let dummyCalabresa = ItemJSON(name: "Calabresa com queijo e vinagrete", price: 26, image: "LanchePlaceHolder")
let dummyCarneLouca = ItemJSON(name: "Carne Louca", price: 26, image: "LanchePlaceHolder")
let dummyBolinha = ItemJSON(name: "Bolinhos de 3 queijos do porpeta", price: 26, image: "LanchePlaceHolder")

let dummyItens1 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil)]
let dummyOrder1 = OrderJSON(name: "Carol", items: dummyItens1, totalValue: 26)


let dummyItens2 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil), OrderItem(item: dummyBolinha, quantity: 5, comments: nil)]
let dummyOrder2 = OrderJSON(name: "Rodrigo", items: dummyItens2, totalValue: 26)


let dummyCollection = [dummyOrder1, dummyOrder2]


let emptyOrder = OrderJSON(name: "", items: [], totalValue: 0)



//{
//    "Nome": "",
//    "Total": 50,
//    "Itens": {
//         "Item": {
//            "Nome":"Carne Louca",
//            "Quantidade": 1,
//            "Preco": 26,
//            "Observacoes": "Nenhuma observação"
//        },
//        "Item" : {
//            "Nome":"Chá Gelado",
//            "Quantidade": 2,
//            "Preco": 6,
//            "Observacoes": "Nenhuma observação"
//        }
//    }
//}
