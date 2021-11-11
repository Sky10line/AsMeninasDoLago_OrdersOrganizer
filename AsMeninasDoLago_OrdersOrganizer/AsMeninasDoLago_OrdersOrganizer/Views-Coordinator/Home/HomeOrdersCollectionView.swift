//
//  OpenOrdersInCells.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct HomeOrdersCollectionViewCell: View {
	let item: OrderJSON
	let action: (() -> Void)?
	@State private var tap: Bool = false
	
	var body: some View {
		Button(action: {
			tap = true
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				tap = false
			}
			action?()
		}, label: {
				VStack {
					if let name = item.name {
						HStack {
							Text(name)
								.fontWeight(.bold)
								.foregroundColor(Color(UIColor.appGreen))
								.multilineTextAlignment(.leading)
								.frame(width: nil, height: 50, alignment: .topLeading)
								.padding(.horizontal)
									
							Spacer()
						}.padding(.top)
							
						Spacer(minLength: 4)
							
						if let total = item.totalValue {
							HStack {
								Text(total.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
									.foregroundColor(.black)
									.fontWeight(.medium)
									.padding(.horizontal)
										
								Spacer()
							}.padding(.bottom)
						}
					}
				}.zIndex(1)
				.background(Color(UIColor.gray3))
				.cornerRadius(20)
				.shadow(radius: 4)
		})
		.scaleEffect(tap ? 0.95 : 1)
		.animation(.spring(response: 0.6, dampingFraction: 1))
	}
}

struct HomeOrdersCollectionView: View {
	let data: Array<OrderJSON>
    @Binding var isModalToBeShown: Bool
    @Binding var dataToBeShown: OrderJSON
	@Binding var searchText: String
	
	#if os(iOS)
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
	let layout = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16)
	]
	
	let layoutRegular = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16)
	]
	
    var body: some View {
		LazyVGrid(columns: horizontalSizeClass == .regular ? layoutRegular : layout, spacing: 16) {
				ForEach(data, id: \.self) { item in
					if item.name?.lowercased().contains(searchText.lowercased()) ?? true || searchText.isEmpty {
						HomeOrdersCollectionViewCell(item: item, action: {
							isModalToBeShown = true
							dataToBeShown = item
							print("Cliquei num item da collection")
						}).transition(.opacity.combined(with: .slide).animation(.easeInOut))
						.animation(.easeInOut(duration: 0.5))
					}
				}
			}.padding(.horizontal)
			.padding(.vertical, 8)
		
    }
}
