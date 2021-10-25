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
		}).transition(.opacity.combined(with: .slide).animation(.easeInOut))
		.animation(.easeInOut(duration: 0.5))
		.scaleEffect(tap ? 0.95 : 1)
		.animation(.spring(response: 0.6, dampingFraction: 1))
	}
}

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
					HomeOrdersCollectionViewCell(item: item, action: nil)
				}
			}.padding(.horizontal)
			.padding(.vertical, 8)
		}.zIndex(0)
    }
}

struct HomeOrdersCollectionView_Previews: PreviewProvider {
    static var previews: some View {
		let orders = [
			OrderJSON(name: "Rodrigo", totalValue: 10.00),
			OrderJSON(name: "Pilar de Souza Rocha da Silva", totalValue: 50.00)
		]
		HomeOrdersCollectionView(data: orders)
    }
}
