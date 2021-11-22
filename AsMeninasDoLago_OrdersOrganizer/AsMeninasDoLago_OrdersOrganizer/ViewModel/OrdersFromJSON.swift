//
//  OrdersFromJSON.swift
//  AsMeninasDoLago
//
//  Created by Caroline Viana on 21/11/21.
//

import Foundation

struct OrderFromJSON: Codable {
    let itens: [ItemFromJSON]
    let nome: String
    let total: Int

    enum CodingKeys: String, CodingKey {
        case itens = "Itens"
        case nome = "Nome"
        case total = "Total"
    }
}

// MARK: - Iten
struct ItemFromJSON: Codable {
    let nome, observacoes: String
    let preco, quantidade: Int
    let nomeImagem: String?

    enum CodingKeys: String, CodingKey {
        case nome = "Nome"
        case observacoes = "Observacoes"
        case preco = "Preco"
        case quantidade = "Quantidade"
        case nomeImagem = "Nome Imagem"
    }
}

typealias OrdersFromJSON = [OrderFromJSON]
