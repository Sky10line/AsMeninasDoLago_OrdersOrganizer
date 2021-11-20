//
//  DebugHelper.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 26/10/21.
//

import Foundation

class DebugHelper {
	func createCategoryMock() -> [CategoryJSON] {
//		let items = [dummyCarneLouca,
//					dummyCalabresa,
//					ItemJSON(name: "Pernil", price: 27.00, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Sanduiches")
//		 ]
//
//		let items2 = [ItemJSON(name: "Cachorro quente", price: 13.00, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Lanches"),
//					ItemJSON(name: "Queijo quente", price: 24.00, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Mais Lanches"),
//					ItemJSON(name: "Pernil", price: 27.00, image: "LanchePlaceHolder", category: "Lanches", subcategory: "Mais Lanches")
//		 ]
//
//		let sub = [SubcategoriesJSON(name: "Sanduiches", items: items),
//				   SubcategoriesJSON(name: "Mais Lanches", items: items2)
//		]
//
//		let itemsDrinks = [ItemJSON(name: "Refrigerante", price: 5.00, image: "LanchePlaceHolder", category: "Bebidas", subcategory: "Mais Drinks"),
//						   ItemJSON(name: "Cerveja", price: 24.00, image: "LanchePlaceHolder", category: "Bebidas", subcategory: "Drinks")]
		
		let mock = [CategoryJSON(name: "Bebidas", subcategories: [])]
		
		return mock
	}
	
	func createFinishedDateMock() -> [FinishedDatesJSON] {
		let orders = dummyCollection
//            [
//			OrderJSON(name: "Rodrigo", totalValue: 10.00),
//			OrderJSON(name: "Rafael", totalValue: 50.00),
//			OrderJSON(name: "Roger", totalValue: 50.00),
//			OrderJSON(name: "Aline", totalValue: 50.00)
//		]
		
//		let orders1 = [
//			OrderJSON(name: "Gabriel", totalValue: 10.00),
//			OrderJSON(name: "Fernando", totalValue: 50.00),
//			OrderJSON(name: "Marcelo", totalValue: 50.00),
//			OrderJSON(name: "Epitacio", totalValue: 50.00),
//			OrderJSON(name: "Lincoln", totalValue: 50.00)
//		]
//
//		let orders2 = [
//			OrderJSON(name: "Luana", totalValue: 10.00),
//			OrderJSON(name: "Matheus", totalValue: 50.00),
//			OrderJSON(name: "João", totalValue: 50.00),
//			OrderJSON(name: "Lucas", totalValue: 50.00),
//			OrderJSON(name: "Linus", totalValue: 50.00)
//		]
		
		let finishedDates = [
			FinishedDatesJSON(dateTitle: "2 de out. 2021", finishedOrders: orders),
//			FinishedDatesJSON(dateTitle: "15 de nov. 2021", finishedOrders: orders1),
//			FinishedDatesJSON(dateTitle: "30 de dez. 2021", finishedOrders: orders2)
		]
		
		return finishedDates
	}
}
