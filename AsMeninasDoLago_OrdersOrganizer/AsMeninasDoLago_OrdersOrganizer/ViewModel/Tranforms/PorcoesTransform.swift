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
			ItemJSON(name: "Bolinhas de queijo da Joice", price: json.bolinhasDeQueijoDaJoice, image: "BolinhasDeQueijoDaJoice"),
			ItemJSON(name: "Bolinhos de 3 queijos do porpeta", price: json.bolinhosDe3QueijosDoPorpe, image: "BolinhosDe3QueijosDoPorpeta"),
			ItemJSON(name: "Bolinhos de carne do porpeta", price: json.bolinhosDeCarneDoPorpeta, image: "BolinhosDeCarneDoPorpeta"),
			ItemJSON(name: "Camarão Cream", price: json.camaraoCream, image: "CamaraoCream"),
			ItemJSON(name: "Coxinhas da joice", price: json.coxinhasDaJoice, image: "CoxinhasDaJoice"),
			ItemJSON(name: "Croquetes da Dorinha", price: json.croquetesDaDorinha, image: "CroquetesDaDorinha"),
			ItemJSON(name: "Dadinhos de tapioca de Cibele", price: json.dadinhosDeTapiocaDeCibele, image: "DadinhosDeTapiocaDeCibele"),
			ItemJSON(name: "Mandioca Cream", price: json.mandiocaCream, image: "MandiocaCream")
		])
		
		entity = CategoryJSON(name: "Porções", subcategories: [sub])
	}
}
