//
//  FinishedOrdersCollectionView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 03/11/21.
//

import SwiftUI

struct FinishedOrdersCollectionView: View {
	let data: [FinishedDatesJSON]
	
	let ordersLayout = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]
	
	let layout = [GridItem(.flexible(), spacing: 4)]
	
	@Binding var isModalToBeShown: Bool
	@Binding var dataToBeShown: OrderJSON
	@Binding var searchText: String
	
	var body: some View {
		LazyVGrid(columns: layout, spacing: 0) {
			ForEach(data, id: \.self) { date in
				
				if let name = date.dateTitle, let orders = date.finishedOrders {
					if !orders.filter({ $0.name?.lowercased().contains(searchText.lowercased()) ?? false }).isEmpty || searchText.isEmpty {
					VStack {
						
						VStack {
							Divider()
						}
						
							
						HStack {
							Text(name)
								.font(.title2)
								.fontWeight(.bold)
							Spacer()
						}
					}.transition(.opacity.combined(with: .slide).animation(.easeInOut))
					.animation(.easeInOut(duration: 0.5))
					}
				}
				
				
				LazyVGrid(columns: ordersLayout, spacing: 16) {
					if let orders = date.finishedOrders {
						ForEach(orders, id: \.self) { order in
							if order.name?.lowercased().contains(searchText.lowercased()) ?? false || searchText.isEmpty {
								HomeOrdersCollectionViewCell(item: order, action: {
									isModalToBeShown = true
									dataToBeShown = order
									print("Cliquei num item da collection")
								}).transition(.opacity.combined(with: .slide).animation(.easeInOut))
								.animation(.easeInOut(duration: 0.5))
							}
						}
					}
				}.padding(.vertical)
			}
		}
		.padding(.horizontal)
		.padding(.vertical, 8)
	}
}
