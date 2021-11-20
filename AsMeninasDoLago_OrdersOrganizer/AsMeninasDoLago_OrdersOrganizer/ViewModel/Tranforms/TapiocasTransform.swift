//
//  TapiocasTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct TapiocasTransform {
	var entity: CategoryJSON
	
	init(json: Tapiocas) {
		
		//Bebidas
		let salgadas = SalgadasTransform(json: json.salgadas).entity
		let doces = DocesTransform(json: json.doces).entity
		
		entity = CategoryJSON(name: "Tapiocas", subcategories: [salgadas, doces])
	}
}

struct SalgadasTransform {
	var entity: SubcategoriesJSON
	
	init(json: Salgadas) {
		entity = SubcategoriesJSON(name: "Salgadas", items: [
			ItemJSON(name: "Carne seca", price: json.carneSeca, image: ""),
			ItemJSON(name: "Frango", price: json.frango, image: ""),
			ItemJSON(name: "Peito de peru", price: json.peitoDePeru, image: ""),
			ItemJSON(name: "Presunto com queijo", price: json.presuntoCOMQueijo, image: "")
		])
	}
}

struct DocesTransform {
	var entity: SubcategoriesJSON
	
	init(json: Doces) {
		entity = SubcategoriesJSON(name: "Doces", items: [
			ItemJSON(name: "Doce de leito", price: json.doceDeLeite, image: ""),
			ItemJSON(name: "Leito condensado com coco", price: json.leiteCondensadoCOMCoco, image: ""),
			ItemJSON(name: "Nutella com banana", price: json.nutellaCOMBanana, image: ""),
			ItemJSON(name: "Nutella com morango", price: json.nutellaCOMMorango, image: ""),
			ItemJSON(name: "Romeu e Julieta", price: json.romeuEJulieta, image: "")
		])
	}
}

