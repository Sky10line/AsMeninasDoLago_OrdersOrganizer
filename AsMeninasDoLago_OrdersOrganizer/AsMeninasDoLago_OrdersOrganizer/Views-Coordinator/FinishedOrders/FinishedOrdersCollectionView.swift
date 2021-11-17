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
	
	let ordersLayoutRegular = [
			GridItem(.flexible(), spacing: 8),
			GridItem(.flexible(), spacing: 8),
			GridItem(.flexible(), spacing: 8)
		]

	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
	var isShow: Bool = false
	
	@Binding var selectedModal: ContentView.Modals
	@Binding var dataToBeShown: OrderJSON2
	@Binding var searchText: String
	
	var body: some View {
		LazyVGrid(columns: layout, spacing: 0) {
			ForEach(data, id: \.self) { date in
				
				if let name = date.dateTitle, let orders = date.finishedOrders {
					ifleteee(name: name, orders: orders)
					
					
					LazyVGrid(columns: horizontalSizeClass == .regular ? ordersLayoutRegular : ordersLayout, spacing: 16) {
						ForEach(orders, id: \.self) { order in
                            lazyvgridforeach(order: order)
						}
						
					}
					
                    if !orders.filter({ $0.name.lowercased().contains(searchText.lowercased()) }).isEmpty || searchText.isEmpty {
						outroifla(orders: orders)
					}
                }
			}
		}
		.padding(.horizontal)
	}
	
	func countTotal(orders: [OrderJSON2]) -> Double {
		var total: Double = 0.00
		
		for order in orders {
			total += order.totalValue ?? 0.00
		}
		
		return total
	}
    
    private func ifleteee(name: String, orders: [OrderJSON2]) -> some View {
        Group {
            if !orders.filter({ $0.name.lowercased().contains(searchText.lowercased()) }).isEmpty || searchText.isEmpty {
                VStack(spacing: 0) {
                    
                    VStack {
                        Divider()
                    }
                    
                    
                    HStack {
                        Text(name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.vertical)
                        Spacer()
                    }
                }.transition(.opacity.combined(with: .slide).animation(.easeInOut))
                .animation(.easeInOut(duration: 0.5))
            }
        }
    }
    
    private func lazyvgridforeach(order: OrderJSON2) -> some View {
        Group {
            if order.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty {
                HomeOrdersCollectionViewCell(item: order, action: {
                    selectedModal = .finishedOrderDetails
                    dataToBeShown = order
                    print("Cliquei num item da collection")
                }).transition(.opacity.combined(with: .slide).animation(.easeInOut))
                .animation(.easeInOut(duration: 0.5))
                //Text("Água com gás é muito ruim")
            }
        }
    }
    
    private func outroifla(orders: [OrderJSON2]) -> some View {
        Group {
            HStack {
                Spacer()
                
                Text("Total: " + countTotal(orders: orders).asCurrencyBR()!)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .padding(.vertical)
            }.transition(.opacity.combined(with: .slide).animation(.easeInOut))
            .animation(.easeInOut(duration: 0.5))
        }
    }
}
