//
//  PorcoesTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct PorcoesTransform {
	var entity: CategoryJSON
	
	init(json: Porcoes) {
		let sub = SubcategoriesJSON(name: "", items: [
			ItemJSON(name: "Bolinhas de queijo da Joice", price: json.bolinhasDeQueijoDaJoice, image: ""),
			ItemJSON(name: "Bolinhos de 3 queijos do Porpeta", price: json.bolinhosDe3QueijosDoPorpe, image: ""),
			ItemJSON(name: "Bolinhos de carne do Porpeta", price: json.bolinhosDeCarneDoPorpeta, image: ""),
			ItemJSON(name: "Camarão cream", price: json.camaraoCream, image: ""),
			ItemJSON(name: "Coxinhas da Joice", price: json.coxinhasDaJoice, image: ""),
			ItemJSON(name: "Croquetes da Dorinha", price: json.croquetesDaDorinha, image: ""),
			ItemJSON(name: "Dadinhos de tapioca de Cibele", price: json.dadinhosDeTapiocaDeCibele, image: ""),
			ItemJSON(name: "Mandioca cream", price: json.mandiocaCream, image: "")
		])
		
		entity = CategoryJSON(name: "Porções", subcategories: [sub])
	}
}
