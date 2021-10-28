//
//  DebugHelper.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 26/10/21.
//

import Foundation

class DebugHelper {
	func createCategoryMock() -> [CategoryJSON] {
		let items = [ItemJSON(name: "Carne Louca", price: 13.00, image: "LanchePlaceHolder"),
					ItemJSON(name: "Calabresa com queijo e vinagrete", price: 24.00, image: "LanchePlaceHolder"),
					ItemJSON(name: "Pernil", price: 27.00, image: "LanchePlaceHolder")
		 ]
		let sub = [SubcategoriesJSON(name: "Sanduiches", items: items),
				   SubcategoriesJSON(name: "Mais Lanches", items: items)
		]
		
		let itemsDrinks = [ItemJSON(name: "Refrigerante", price: 5.00, image: "LanchePlaceHolder"),
						   ItemJSON(name: "Cerveja", price: 24.00, image: "LanchePlaceHolder")]
		
		let subDrinks = [SubcategoriesJSON(name: "Drinks", items: itemsDrinks),
				   SubcategoriesJSON(name: "Mais Drinks", items: itemsDrinks)
		]
		
		let mock = [CategoryJSON(name: "Lanches", subcategories: sub),
					CategoryJSON(name: "Bebidas", subcategories: subDrinks)]
		
		return mock
	}
}
