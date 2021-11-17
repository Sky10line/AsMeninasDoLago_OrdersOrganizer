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
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				action?()
			}
		}, label: {
			VStack {
				if let image = item.image {
					Image(image)
						.resizable()
						.scaledToFill()
						.overlay(
							VStack {
								if let name = item.name {
									HStack {
										Text(name)
											.fontWeight(.bold)
											.font(.body)
											.foregroundColor(.white)
											.multilineTextAlignment(.leading)
											.padding(.horizontal)
											.frame(width: nil, height: 50, alignment: .center)
										Spacer()
									}.frame(width: nil, height: 50, alignment: .bottomLeading)
									.background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.appBrown), Color.clear]), startPoint: .center, endPoint: .top))
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
									}.background(Color(UIColor.appBrown))
								}
							}.padding(.bottom)
							.padding(.top, 160)
							
						)
				}
				HStack{ Spacer() }
			}.padding(.bottom, 70)
			.background(Color(UIColor.appBrown))
			.zIndex(1)
			.cornerRadius(20)
			.shadow(radius: 4)
		}).scaleEffect(tap ? 0.95 : 1)
		.animation(.spring(response: 0.6, dampingFraction: 1))
	}
}

struct NewOrderCollectionView: View {
	let data: [SubcategoriesJSON]
	
	let layout = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]
    
	let layoutRegular = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]

	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
    @Binding var isModalToBeShown: Bool
    @Binding var dataToBeShown: ItemJSON
	
	var body: some View {
		VStack {
			ForEach(data, id: \.self) { subcategory in
				if let name = subcategory.name {
					HStack {
						Text(name)
							.font(.title2)
							.fontWeight(.bold)
							.foregroundColor(Color(UIColor.appGreen))
						VStack{
							Divider()
								.background(Color(UIColor.appGreen))
						}
					}
				}
				if let items = subcategory.items {
					LazyVGrid(columns: horizontalSizeClass == .regular ? layoutRegular : layout, spacing: 16) {
						ForEach(items, id: \.self) { item in
							NewOrderCollectionViewCell(item: item, action: {
                                isModalToBeShown = true
                                dataToBeShown = item
                                print("cliquei na collection")
                            })
						}
					}.padding(.vertical)
				}
			}
		}.padding(.horizontal)
		.padding(.vertical, 8)
	}
}

struct NewOrderCollectionView_Previews: PreviewProvider {
    static var previews: some View {
		let subcategories = (DebugHelper().createCategoryMock().first?.subcategories)!
        NewOrderCollectionView(data: subcategories, isModalToBeShown: .constant(true), dataToBeShown: .constant(dummyCalabresa))
    }
}
