//
//  OrderJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 16/10/21.
//

import Foundation

struct OrderJSON: Decodable, Hashable {
    var name: String
    var items: [Itemn]
    var totalValue: Double
}

struct Itemn: Decodable, Hashable {
    var nome: String
    var quantidade: Int
    var preco: Double
    var observacoes: String
}


struct OrderJSON2Element: Codable {
    let itens: [Iten]
    let nome: String
    let total: Int

    enum CodingKeys: String, CodingKey {
        case itens = "Itens"
        case nome = "Nome"
        case total = "Total"
    }
}

// MARK: - Iten
struct Iten: Codable {
    let nome, observacoes: String
    let preco, quantidade: Int

    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
        case observacoes = "Observacoes"
        case preco = "Preco"
        case quantidade = "Quantidade"
    }
}

typealias OrderJSON2 = [OrderJSON2Element]



struct OrderItem: Decodable, Hashable {
    var item: ItemJSON
    var quantity: Int
    var comments: String?
}


// MARK: - Dummy Data

//let dummyCalabresa = ItemJSON(name: "Calabresa com queijo e vinagrete", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
//let dummyCarneLouca = ItemJSON(name: "Carne Louca", price: 26, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
//let dummyBolinha = ItemJSON(name: "Bolinhos de 3 queijos do porpeta", price: 26, image: "LanchePlaceHolder", category: "sanduiche", subcategory: "Lanches")
//Itemn(nome: <#T##String#>, quantidade: <#T##Int#>, preco: <#T##Double#>, observacoes: <#T##String#>)
//let dummyCalabresa = ItemJSON(name: "Calabresa com queijo e vinagrete", price: 26, image: "LanchePlaceHolder")
//let dummyCarneLouca = ItemJSON(name: "Carne Louca", price: 26, image: "LanchePlaceHolder")
//let dummyBolinha = ItemJSON(name: "Bolinhos de 3 queijos do porpeta", price: 26, image: "LanchePlaceHolder")
//
//let dummyItens1 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil)]
//let dummyOrder1 = OrderJSON(name: "Carol", items: dummyItens1, totalValue: 26)
//
//
//let dummyItens2 = [OrderItem(item: dummyCarneLouca, quantity: 2, comments: "Sem ketchup"), OrderItem(item: dummyCalabresa, quantity: 1, comments: nil), OrderItem(item: dummyBolinha, quantity: 5, comments: nil)]
//let dummyOrder2 = OrderJSON(name: "Rodrigo", items: dummyItens2, totalValue: 26)
//
//
//let dummyCollection = [dummyOrder1, dummyOrder2]


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
