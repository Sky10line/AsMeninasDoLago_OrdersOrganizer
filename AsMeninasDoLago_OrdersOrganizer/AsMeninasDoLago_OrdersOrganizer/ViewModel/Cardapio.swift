//
//  Cardapio.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 18/11/21.
//

import Foundation

// MARK: - Cardapio
struct Cardapio: Codable {
    let bebidas: Bebidas
    let caldos: Caldos
    let escondidinhos: Escondidinhos
    let lanches: Lanches
    let porcoes: Porcoes
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
    let doseGin, doseVodka, doseCachaça, gt: Double
    let lata, longNeck: Double

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
    let chaGelado, redBull, refrigerante, agua: Double
    let aguaTonica: Double

    enum CodingKeys: String, CodingKey {
        case chaGelado = "Chá gelado"
        case redBull = "Red Bull"
        case refrigerante = "Refrigerante"
        case agua = "Água"
        case aguaTonica = "Água tônica"
    }
}

// MARK: - SucosDetox
struct SucosDetox: Codable {
    let polpaBranca, polpaVerde, polpaVermelha: Double

    enum CodingKeys: String, CodingKey {
        case polpaBranca = "Polpa branca"
        case polpaVerde = "Polpa verde"
        case polpaVermelha = "Polpa vermelha"
    }
}

// MARK: - Caldos
struct Caldos: Codable {
    let diversosSabores: Double

    enum CodingKeys: String, CodingKey {
        case diversosSabores = "Diversos sabores"
    }
}

// MARK: - Escondidinhos
struct Escondidinhos: Codable {
    let baconCOMChampignon, camarao, estrogonofeDeFrango: Double

    enum CodingKeys: String, CodingKey {
        case baconCOMChampignon = "Bacon com champignon"
        case camarao = "Camarão"
        case estrogonofeDeFrango = "Estrogonofe de frango"
    }
}

// MARK: - Escondidinhos
struct Porcoes: Codable {
	let bolinhasDeQueijoDaJoice, bolinhosDe3QueijosDoPorpe, bolinhosDeCarneDoPorpeta, camaraoCream,
		coxinhasDaJoice, croquetesDaDorinha, dadinhosDeTapiocaDeCibele, mandiocaCream, porcaoDeFrios: Double

	enum CodingKeys: String, CodingKey {
		case bolinhasDeQueijoDaJoice = "Bolinhas de queijo da Joice"
		case bolinhosDe3QueijosDoPorpe = "Bolinhos de 3 queijos do porpe"
		case bolinhosDeCarneDoPorpeta = "Bolinhos de carne do porpeta"
		case camaraoCream = "Camarão Cream"
		case coxinhasDaJoice = "Coxinhas da joice"
		case croquetesDaDorinha = "Croquetes da Dorinha"
		case dadinhosDeTapiocaDeCibele = "Dadinhos de tapioca de Cibele"
		case mandiocaCream = "Mandioca Cream"
		case porcaoDeFrios = "Porção de Frios"
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
    let cheddarBaconCOM1Salsicha, cheddarBaconCOM2Salsichas, completoCOM1Salsicha, completoCOM2Salsichas: Double

    enum CodingKeys: String, CodingKey {
        case cheddarBaconCOM1Salsicha = "Cheddar bacon com 1 salsicha"
        case cheddarBaconCOM2Salsichas = "Cheddar bacon com 2 salsichas"
        case completoCOM1Salsicha = "Completo com 1 salsicha"
        case completoCOM2Salsichas = "Completo com 2 salsichas"
    }
}

// MARK: - Sanduiches
struct Sanduiches: Codable {
    let calabresaCOMQueijoEVinagre, carneLouca, pernil: Double

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
    let camarao, frango, palmito: Double

    enum CodingKeys: String, CodingKey {
        case camarao = "Camarão"
        case frango = "Frango"
        case palmito = "Palmito"
    }
}

// MARK: - Tortas
struct Tortas: Codable {
    let alhoPoroCOMCatupiry, camarao, frangoCOMPalmito, palmito: Double

    enum CodingKeys: String, CodingKey {
        case alhoPoroCOMCatupiry = "Alho poró com catupiry"
        case camarao = "Camarão"
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
    let doceDeLeite, leiteCondensadoCOMCoco, nutellaCOMBanana, nutellaCOMMorango: Double
    let romeuEJulieta: Double

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
    let carneSeca, frango, peitoDePeru, presuntoCOMQueijo: Double

    enum CodingKeys: String, CodingKey {
        case carneSeca = "Carne seca"
        case frango = "Frango"
        case peitoDePeru = "Peito de peru"
        case presuntoCOMQueijo = "Presunto com queijo"
    }
}


