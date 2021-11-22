//
//  FinishedOrdersFromJSON.swift
//  AsMeninasDoLago
//
//  Created by Caroline Viana on 21/11/21.
//

import Foundation
//
//struct FinishedOrderFromJSON: Codable {
//    let nome: String
//    let total: Double
//    let data: String
//    let itens: [ItemForFinishedOrder]
//
//    enum CodingKeys: String, CodingKey {
//        case nome = "Nome"
//        case total = "Total"
//        case data = "Data"
//        case itens = "Itens"
//    }
//}
//
//// MARK: - Item
//struct ItemForFinishedOrder: Codable {
//    let nome: String
//    let quantidade: Int
//    let valor: Double
//
//    enum CodingKeys: String, CodingKey {
//        case nome = "Nome"
//        case quantidade = "Quantidade"
//        case valor = "Valor"
//    }
//}

struct FinishedOrderFromJSONElement: Codable {
    let data: String
    let itens: [ItemForFinishedOrder]
    let nome: String
    let total: Int

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case itens = "Itens"
        case nome = "Nome"
        case total = "Total"
    }
}

// MARK: - Iten
struct ItemForFinishedOrder: Codable {
    let nome, nomeImagem: String
    let quantidade, valor: Int

    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
        case quantidade = "Quantidade"
        case nomeImagem = "Nome Imagem"
        case valor = "Valor"
    }
}

typealias FinishedOrderFromJSON = [FinishedOrderFromJSONElement]
