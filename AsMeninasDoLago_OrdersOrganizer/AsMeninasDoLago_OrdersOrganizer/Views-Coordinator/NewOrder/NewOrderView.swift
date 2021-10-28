//
//  NewOrderView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 21/10/21.
//

import SwiftUI

struct NewOrderView: View {
	@State private var name = ""
	let categories = DebugHelper().createCategoryMock()
	
	@State private var selectedTab: String = ""

    var body: some View {
		VStack {
			NameTextField(name: $name)
				.padding(.top)
			
			Divider()
				.padding(.horizontal)
				.padding(.top, 8)
			
			TabNewOrder(tabs: categories, selectedTab: $selectedTab)
			
			Divider()
				.padding(.horizontal)
			
			Spacer()
			ScrollView {
				NewOrderCollectionView(data: categories.first(where: { $0.name == selectedTab})?.subcategories ?? [])
					.animation(.spring(response: 1, dampingFraction: 1))
			}
		}.background(Color.white.ignoresSafeArea())
		.navigationBarTitle("Nova comanda", displayMode: .inline)
    }
}

struct NameTextField: View {
	@Binding var name: String
	
	var body: some View {
		HStack {
			TextField("Nome do cliente", text: $name)
				.padding()
		}.background(Color.clear)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.black, lineWidth: 1)
		).padding(.horizontal)
	}
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
		NewOrderView()
    }
}
