//
//  HomeView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct HomeView: View {
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	
	@State private var showModal = false
	@State var data: OrderJSON = OrderJSON(name: "Placeholder", totalValue: 0).self
	
	let orders = [
		OrderJSON(name: "Rodrigo", totalValue: 10.00),
		OrderJSON(name: "Rafael", totalValue: 50.00),
		OrderJSON(name: "Roger", totalValue: 50.00),
		OrderJSON(name: "Aline", totalValue: 50.00)
	]
	
	#if os(iOS)
		@Environment(\.verticalSizeClass) private var verticalSizeClass
	#endif
		
	
	init() {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
	}
	
	var body: some View {
			VStack {
				NavBar(title: "Comandas")
				
				SearchBar(searchText: $searchText)
				Divider()
					.padding(.top, 8)
					.padding(.horizontal)
				
				ScrollView {
					HomeOrdersCollectionView(data: orders, isModalToBeShown: $showModal, dataToBeShown: $data, searchText: $searchText)
				}
				Spacer()
				
				NavigationLink(
					destination: NewOrderView(),
					isActive: $isShowingNewOrderView,
					label: { EmptyView() })
				
				BigButton(text: "Nova comanda") {
					isShowingNewOrderView = true
				}
				Spacer(minLength: UIScreen.main.bounds.height / 5.5)
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
			.sheet(isPresented: $showModal, content: {
					modalDetailsView(testData: $data)
						.ignoresSafeArea()
				})
	}
}
