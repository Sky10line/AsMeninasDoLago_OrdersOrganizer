//
//  SalgadosTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct SalgadosTransform {
	var entity: CategoryJSON
	
	init(json: Salgados) {
		
		//Bebidas
		let empadas = EmpadasTransform(json: json.empadas).entity
		let tortas = TortasTransform(json: json.tortas).entity
		
		entity = CategoryJSON(name: "Salgados", subcategories: [empadas, tortas])
	}
}

struct EmpadasTransform {
	var entity: SubcategoriesJSON
	
	init(json: Empadas) {
		entity = SubcategoriesJSON(name: "Empadas", items: [
			ItemJSON(name: "Camarão", price: json.camarao, image: ""),
			ItemJSON(name: "Frango", price: json.frango, image: ""),
			ItemJSON(name: "Palmito", price: json.palmito, image: "")
		])
	}
}

struct TortasTransform {
	var entity: SubcategoriesJSON
	
	init(json: Tortas) {
		entity = SubcategoriesJSON(name: "Tortas", items: [
			ItemJSON(name: "Alho-poró com catupiry", price: json.alhoPoroCOMCatupiry, image: ""),
			ItemJSON(name: "Camarão", price: json.camarao, image: ""),
			ItemJSON(name: "Frango com palmito", price: json.frangoCOMPalmito, image: ""),
			ItemJSON(name: "Palmito", price: json.palmito, image: "")
		])
	}
}
