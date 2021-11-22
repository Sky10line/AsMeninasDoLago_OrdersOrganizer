//
//  BebidasTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct BebidasTransform {
	var entity: CategoryJSON
	
	init(json: Bebidas) {
		
		//Bebidas
		let alcoolico = AlcoolicoTransform(json: json.alcoolico).entity
		let naoAlcoolico = NaoAlcoolicoTransform(json: json.naoAlcoolico).entity
		let sucoDetox = SucoDetoxTransform(json: json.sucosDetox).entity
		
		entity = CategoryJSON(name: "Bebidas", subcategories: [alcoolico, naoAlcoolico, sucoDetox])
	}
}

struct AlcoolicoTransform {
	var entity: SubcategoriesJSON
	
	init(json: Alcoolico) {
		entity = SubcategoriesJSON(name: "Alcoólicos", items: [
			ItemJSON(name: "Dose cachaça", price: json.doseCachaça, image: "Dose cachaça"),
			ItemJSON(name: "Dose gin", price: json.doseGin, image: "DoseGin"),
			ItemJSON(name: "Dose vodka", price: json.doseVodka, image: "DoseVodka"),
			ItemJSON(name: "GT", price: json.gt, image: "GT"),
			ItemJSON(name: "Cerveja lata", price: json.lata, image: "Lata"),
			ItemJSON(name: "Long neck", price: json.longNeck, image: "LongNeck")
		])
	}
}

struct NaoAlcoolicoTransform {
	var entity: SubcategoriesJSON
	
	init(json: NaoAlcoolico) {
		entity = SubcategoriesJSON(name: "Não Alcoólicos", items: [
			ItemJSON(name: "Água", price: json.agua, image: "Agua"),
			ItemJSON(name: "Água tônica", price: json.aguaTonica, image: "AguaTonica"),
			ItemJSON(name: "Chá gelado", price: json.chaGelado, image: "ChaGelado"),
			ItemJSON(name: "Red bull", price: json.redBull, image: "RedBull"),
			ItemJSON(name: "Refrigerante", price: json.refrigerante, image: "Refrigerantes")
		])
	}
}

struct SucoDetoxTransform {
	var entity: SubcategoriesJSON
	
	init(json: SucosDetox) {
		entity = SubcategoriesJSON(name: "Sucos Detox", items: [
			ItemJSON(name: "Polpa branca", price: json.polpaBranca, image: "PolpaBranca"),
			ItemJSON(name: "Polpa verde", price: json.polpaVerde, image: "PolpaVerde"),
			ItemJSON(name: "Polpa vermelha", price: json.polpaVermelha, image: "PolpaVermelha")
		])
	}
}
