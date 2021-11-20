//
//  CaldosTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct CaldosTransform {
	var entity: CategoryJSON
	
	init(json: Caldos) {
		let sub = SubcategoriesJSON(name: "", items: [ItemJSON(name: "Diversos sabores", price: json.diversosSabores, image: "")])
		
		entity = CategoryJSON(name: "Caldos", subcategories: [sub])
	}
}
