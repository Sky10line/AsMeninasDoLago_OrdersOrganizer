//
//  OpenOrdersInCells.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct HomeOrdersCollectionView: View {
	let data: Array<OrderJSON>
	
	let layout = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16)
	]
	
    var body: some View {
		ScrollView {
			LazyVGrid(columns: layout, spacing: 16) {
				ForEach(data, id: \.self) { item in
					VStack {
						if let name = item.name {
							HStack {
								Text(name)
									.bold()
									.foregroundColor(Color(UIColor.appGreen))
									.multilineTextAlignment(.leading)
									.padding(.horizontal)
									
								Spacer()
							}.padding(.top)
							
							Spacer(minLength: 4)
							
							if let total = item.totalValue {
								HStack {
									Text(total.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
										.padding(.horizontal)
										
										
									Spacer()
								}.padding(.bottom)
							}
						}
					}.background(Color.white)
					.cornerRadius(20)
					.shadow(radius: 5)
				}
			}.padding()
		}
    }
}

struct HomeOrdersCollectionView_Previews: PreviewProvider {
    static var previews: some View {
		let orders = [
			OrderJSON(name: "Rodrigo", totalValue: 10.00),
			OrderJSON(name: "Rafael", totalValue: 50.00)
		]
		HomeOrdersCollectionView(data: orders)
    }
}
