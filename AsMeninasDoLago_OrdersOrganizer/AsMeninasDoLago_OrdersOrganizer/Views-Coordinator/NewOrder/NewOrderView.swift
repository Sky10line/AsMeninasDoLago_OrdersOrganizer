//
//  NewOrderView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 21/10/21.
//

import SwiftUI

struct NewOrderView: View {
	@State private var name = ""
	let tab: [TabNewOrder.Options] = [.lanches, .hotdog, .bebidas]
	@State private var selectedTab: TabNewOrder.Options = .none

    var body: some View {
		VStack {
			NameTextField(name: $name)
				.padding(.top)
			
			Divider()
				.padding(.horizontal)
				.padding(.top, 8)
			
			TabNewOrder(tabs: tab, selectedTab: $selectedTab)
			Spacer()
			
			
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
