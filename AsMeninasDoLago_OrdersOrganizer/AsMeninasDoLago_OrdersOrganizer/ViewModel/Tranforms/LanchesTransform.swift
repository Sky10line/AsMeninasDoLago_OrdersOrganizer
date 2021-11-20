//
//  LanchesTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct LanchesTransform {
	var entity: CategoryJSON
	
	init(json: Lanches) {

		let sanduiches = SanduichesTransform(json: json.sanduiches).entity
		let hotdogs = HotDogsTransform(json: json.hotDog).entity
		
		entity = CategoryJSON(name: "Lanches", subcategories: [sanduiches, hotdogs])
	}
}

struct SanduichesTransform {
	var entity: SubcategoriesJSON
	
	init(json: Sanduiches) {
		entity = SubcategoriesJSON(name: "Sanduíches", items: [
			ItemJSON(name: "Calabresa com queijo e vinagrete", price: json.calabresaCOMQueijoEVinagre, image: ""),
			ItemJSON(name: "Carne louca", price: json.carneLouca, image: ""),
			ItemJSON(name: "Pernil", price: json.pernil, image: "")
		])
	}
}

struct HotDogsTransform {
	var entity: SubcategoriesJSON
	
	init(json: HotDog) {
		entity = SubcategoriesJSON(name: "Hot dogs", items: [
			ItemJSON(name: "Completo com 1 salsicha", price: json.completoCOM1Salsicha, image: ""),
			ItemJSON(name: "Cheddar e bacon com 1 salsicha", price: json.cheddarBaconCOM1Salsicha, image: ""),
			ItemJSON(name: "Completo com 2 salsichas", price: json.completoCOM2Salsichas, image: ""),
			ItemJSON(name: "Cheddar e bacon com 2 salsichas", price: json.cheddarBaconCOM2Salsichas, image: "")
		])
	}
}
