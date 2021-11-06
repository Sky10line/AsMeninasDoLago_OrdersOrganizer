//
//  MenuCollectionView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 05/11/21.
//

import SwiftUI

struct MenuCollectionView: View {
	let data: [SubcategoriesJSON]
	
	let itemsGridLayout = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]
	
	let layout = [GridItem(.flexible(), spacing: 0)]
	
	@Binding var isModalToBeShown: Bool
	@Binding var dataToBeShown: ItemJSON
	
	@Binding var searchText: String
	
	var body: some View {
		LazyVGrid(columns: layout) {
			ForEach(data, id: \.self) { subcategory in
				
				if let name = subcategory.name, let items = subcategory.items {
					if !items.filter({ $0.name?.lowercased().contains(searchText.lowercased()) ?? false }).isEmpty || searchText.isEmpty {
						HStack {
							Text(name)
								.font(.title2)
								.fontWeight(.bold)
								.foregroundColor(Color(UIColor.appGreen))
								.padding(.vertical)
							VStack{
								Divider()
									.background(Color(UIColor.appGreen))
							}
						}.transition(.opacity.combined(with: .slide).animation(.easeInOut))
						.animation(.easeInOut(duration: 0.5))
					}
				}
				
				LazyVGrid(columns: itemsGridLayout, spacing: 16) {
					if let items = subcategory.items {
						ForEach(items, id: \.self) { item in
							if item.name?.lowercased().contains(searchText.lowercased()) ?? false || searchText.isEmpty {
								MenuCollectionViewCell(item: item,
													   action: {
														isModalToBeShown = true
														dataToBeShown = item
														print("cliquei na collection")
														
													   }, editAction: {
														print("cliquei no edit")
													}
								).transition(.opacity.combined(with: .slide).animation(.easeInOut))
								.animation(.easeInOut(duration: 0.5))
							}
						}
					}
				}
			}
		}.padding(.horizontal)
	}
}

struct MenuCollectionViewCell: View {
	let item: ItemJSON
	let action: (() -> Void)?
	let editAction: (() -> Void)?
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
											.padding()
											
										Spacer()
										
										Button(action: {
											editAction?()
										}, label: {
											Image("PencilIcon")
												.foregroundColor(Color(UIColor.appGreen))
												.padding()
										})
									}
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
