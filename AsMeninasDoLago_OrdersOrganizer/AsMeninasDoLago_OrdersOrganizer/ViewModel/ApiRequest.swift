//
//  ApiRequest.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 17/11/21.
//

import Foundation

class ApiRequest {
    @Published var openOrders: [OrderJSON] = []
    @Published var categories: [CategoryJSON] = []
    
    let session = URLSession.shared
    let baseURL = "https://api-grupo1.herokuapp.com/"
    let decoder = JSONDecoder()
    
    private func createRequest(endpoint: String) -> URLRequest? {
        guard let url = URL(string: self.baseURL + endpoint) else {
            print("Erro: URL inválida")
            return nil
        }
        return URLRequest(url: url)
        
    }
    
    private func handleMenu(menu: Cardapio) -> [CategoryJSON] {
        //let categories: [CategoryJSON]
        
        //let category = CategoryJSON(name: , subcategories: [SubcategoriesJSON]?)
        print(menu)
        return []
    }
    
//    func getOpenOrders() {
//        guard let request = createRequest(endpoint: "MostraComandasAbertas") else {
//            print("Erro ao criar request")
//            return
//        }
//
//        session.dataTask(with: request) { data, respose, error in
//            if let erro = error {
//                print("Erro: \(erro.localizedDescription)")
//                return
//            }
//            guard let data = data else { return }
//            if let decodedResponse = try? self.decoder.decode([OrderJSON].self, from: data) {
//                DispatchQueue.main.async {
//                    self.openOrders = decodedResponse
//                }
//            }
//        }
//
//    }
    
    func getMenu() {
        guard let request = createRequest(endpoint: "MostraCardapio") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decodedResponse = try self.decoder.decode(Cardapio.self, from: data)
                        self.handleMenu(menu: decodedResponse)
                    
                }
                catch {
                    print("Erro: \(error.localizedDescription)")
                }
            }
            
        }.resume()

    }
    
    
    
    
}



// MARK: - Welcome
struct Cardapio: Codable {
    let bebidas: Bebidas
    let caldos: Caldos
    let escondidinhos: Escondidinhos
    let lanches: Lanches
    let porcoes: [String: Int]
    let salgados: Salgados
    let tapiocas: Tapiocas

    enum CodingKeys: String, CodingKey {
        case bebidas = "Bebidas"
        case caldos = "Caldos"
        case escondidinhos = "Escondidinhos"
        case lanches = "Lanches"
        case porcoes = "Porcoes"
        case salgados = "Salgados"
        case tapiocas = "Tapiocas"
    }
}

// MARK: - Bebidas
struct Bebidas: Codable {
    let alcoolico: Alcoolico
    let naoAlcoolico: NaoAlcoolico
    let sucosDetox: SucosDetox

    enum CodingKeys: String, CodingKey {
        case alcoolico = "Alcoolico"
        case naoAlcoolico = "Nao-alcoolico"
        case sucosDetox = "Sucos-Detox"
    }
}

// MARK: - Alcoolico
struct Alcoolico: Codable {
    let doseGin, doseVodka, doseCachaça, gt: Int
    let lata, longNeck: Int

    enum CodingKeys: String, CodingKey {
        case doseGin = "Dose Gin"
        case doseVodka = "Dose Vodka"
        case doseCachaça = "Dose cachaça"
        case gt = "GT"
        case lata = "Lata"
        case longNeck = "Long Neck"
    }
}

// MARK: - NaoAlcoolico
struct NaoAlcoolico: Codable {
    let cháGelado, redBull, refrigerante, água: Int
    let águaTônica: Int

    enum CodingKeys: String, CodingKey {
        case cháGelado = "Chá gelado"
        case redBull = "Red Bull"
        case refrigerante = "Refrigerante"
        case água = "Água"
        case águaTônica = "Água tônica"
    }
}

// MARK: - SucosDetox
struct SucosDetox: Codable {
    let polpaBranca, polpaVerde, polpaVermelha: Int

    enum CodingKeys: String, CodingKey {
        case polpaBranca = "Polpa branca"
        case polpaVerde = "Polpa verde"
        case polpaVermelha = "Polpa vermelha"
    }
}

// MARK: - Caldos
struct Caldos: Codable {
    let diversosSabores: Int

    enum CodingKeys: String, CodingKey {
        case diversosSabores = "Diversos sabores"
    }
}

// MARK: - Escondidinhos
struct Escondidinhos: Codable {
    let baconCOMChampignon, camarão, estrogonofeDeFrango: Int

    enum CodingKeys: String, CodingKey {
        case baconCOMChampignon = "Bacon com champignon"
        case camarão = "Camarão"
        case estrogonofeDeFrango = "Estrogonofe de frango"
    }
}

// MARK: - Lanches
struct Lanches: Codable {
    let hotDog: HotDog
    let sanduiches: Sanduiches

    enum CodingKeys: String, CodingKey {
        case hotDog = "Hot-Dog"
        case sanduiches = "Sanduiches"
    }
}

// MARK: - HotDog
struct HotDog: Codable {
    let cheddarBaconCOM1Salsicha, cheddarBaconCOM2Salsichas, completoCOM1Salsicha, completoCOM2Salsichas: Int

    enum CodingKeys: String, CodingKey {
        case cheddarBaconCOM1Salsicha = "Cheddar bacon com 1 salsicha"
        case cheddarBaconCOM2Salsichas = "Cheddar bacon com 2 salsichas"
        case completoCOM1Salsicha = "Completo com 1 salsicha"
        case completoCOM2Salsichas = "Completo com 2 salsichas"
    }
}

// MARK: - Sanduiches
struct Sanduiches: Codable {
    let calabresaCOMQueijoEVinagre, carneLouca, pernil: Int

    enum CodingKeys: String, CodingKey {
        case calabresaCOMQueijoEVinagre = "Calabresa com queijo e vinagre"
        case carneLouca = "Carne Louca"
        case pernil = "Pernil"
    }
}

// MARK: - Salgados
struct Salgados: Codable {
    let empadas: Empadas
    let tortas: Tortas

    enum CodingKeys: String, CodingKey {
        case empadas = "Empadas"
        case tortas = "Tortas"
    }
}

// MARK: - Empadas
struct Empadas: Codable {
    let camarão, frango, palmito: Double

    enum CodingKeys: String, CodingKey {
        case camarão = "Camarão"
        case frango = "Frango"
        case palmito = "Palmito"
    }
}

// MARK: - Tortas
struct Tortas: Codable {
    let alhoPoróCOMCatupiry, camarão, frangoCOMPalmito, palmito: Int

    enum CodingKeys: String, CodingKey {
        case alhoPoróCOMCatupiry = "Alho poró com catupiry"
        case camarão = "Camarão"
        case frangoCOMPalmito = "Frango com palmito"
        case palmito = "Palmito"
    }
}

// MARK: - Tapiocas
struct Tapiocas: Codable {
    let doces: Doces
    let salgadas: Salgadas

    enum CodingKeys: String, CodingKey {
        case doces = "Doces"
        case salgadas = "Salgadas"
    }
}

// MARK: - Doces
struct Doces: Codable {
    let doceDeLeite, leiteCondensadoCOMCoco, nutellaCOMBanana, nutellaCOMMorango: Int
    let romeuEJulieta: Int

    enum CodingKeys: String, CodingKey {
        case doceDeLeite = "Doce de leite"
        case leiteCondensadoCOMCoco = "Leite condensado com coco"
        case nutellaCOMBanana = "Nutella com banana"
        case nutellaCOMMorango = "Nutella com morango"
        case romeuEJulieta = "Romeu e Julieta"
    }
}

// MARK: - Salgadas
struct Salgadas: Codable {
    let carneSeca, frango, peitoDePeru, presuntoCOMQueijo: Int

    enum CodingKeys: String, CodingKey {
        case carneSeca = "Carne seca"
        case frango = "Frango"
        case peitoDePeru = "Peito de peru"
        case presuntoCOMQueijo = "Presunto com queijo"
    }
}


