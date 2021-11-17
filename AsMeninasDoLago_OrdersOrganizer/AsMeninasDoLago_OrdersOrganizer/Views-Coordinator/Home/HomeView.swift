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
	
	@Binding var selectedModal: ContentView.Modals
    @Binding var orderData: OrderJSON2
	
	let orders = dummyCollection
	
    init(selectedModal: Binding<ContentView.Modals>, orderData: Binding<OrderJSON2>) {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
        self._selectedModal = selectedModal
        self._orderData = orderData
	}
	
	var body: some View {
			VStack {
				NavBar(title: "Comandas")
				
				SearchBar(searchText: $searchText)
				Divider()
					.padding(.top, 8)
					.padding(.horizontal)
				
				ZStack(alignment: .bottom) {
					ScrollView {
						HomeOrdersCollectionView(data: orders, selectedModal: $selectedModal, dataToBeShown: $orderData, searchText: $searchText)
						
						Spacer(minLength: 280)
					}
					
					NavigationLink(
						destination: NewOrderView(),
						isActive: $isShowingNewOrderView,
						label: { EmptyView() })
					
					VStack {
						BigButton(text: "Nova comanda") {
							isShowingNewOrderView = true
						}.padding()
						.background(Color.clear)
						Rectangle().opacity(0).frame(height: 150)
					}
				}
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
	}
}
