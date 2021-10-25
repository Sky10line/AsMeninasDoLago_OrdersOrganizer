//
//  NewOrderCollectionView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 24/10/21.
//

import SwiftUI

struct NewOrderCollectionViewCell: View {
	let item: ItemJSON
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
				if let image = item.image {
					Image(image)
						.resizable()
						.scaledToFill()
						.frame(width: 1, height: 130)
				}
				EmptyView()
				VStack {
					if let name = item.name {
						HStack {
							Text(name)
								.fontWeight(.bold)
								.font(.body)
								.foregroundColor(.white)
								.multilineTextAlignment(.leading)
								.padding(.horizontal)
								.frame(width: nil, height: 50, alignment: .topLeading)
							Spacer()
						}
					}
					if let price = item.price {
						HStack {
							Text(price.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
								.fontWeight(.regular)
								.font(.subheadline)
								.foregroundColor(.white)
								.multilineTextAlignment(.leading)
								.padding(.horizontal)
								.padding(.bottom)
							Spacer()
						}
					}
				}
			}.zIndex(1)
			.background(Color(UIColor.appBrown))
			.cornerRadius(20)
			.shadow(radius: 4)
		}).transition(.opacity.combined(with: .slide).animation(.easeInOut))
		.animation(.easeInOut(duration: 0.5))
		.scaleEffect(tap ? 0.95 : 1)
		.animation(.spring(response: 0.6, dampingFraction: 1))
	}
}

struct NewOrderCollectionView: View {
	let data: Array<ItemJSON>
	
	let layout = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: layout, spacing: 16) {
				ForEach(data, id: \.self) { item in
					NewOrderCollectionViewCell(item: item, action: nil)
				}
			}.padding(.horizontal)
			.padding(.vertical, 8)
		}.zIndex(0)
	}
}

struct NewOrderCollectionView_Previews: PreviewProvider {
    static var previews: some View {
		let items = [ItemJSON(name: "Carne Louca", price: 13.00, image: "LanchePlaceHolder"),
					 ItemJSON(name: "Calabresa com queijo e vinagrete", price: 24.00, image: "LanchePlaceHolder")
		]
		NewOrderCollectionView(data: items)
    }
}
