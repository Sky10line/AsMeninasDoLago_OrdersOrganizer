//
//  EscondidinhosTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct EscondidinhosTransform {
	var entity: CategoryJSON
	
	init(json: Escondidinhos) {
		let sub = SubcategoriesJSON(name: "", items: [
			ItemJSON(name: "Bacon com champignon", price: json.baconCOMChampignon, image: "EscondidinhoDeBaconComChampignon"),
			ItemJSON(name: "Camarão", price: json.camarao, image: "EscondidinhoDeCamarao"),
			ItemJSON(name: "Estrogonofe de frango", price: json.estrogonofeDeFrango, image: "EscondidinhoDeEstrogonofeDeFrango")
		])
		
		entity = CategoryJSON(name: "Escondidinhos", subcategories: [sub])
	}
}
