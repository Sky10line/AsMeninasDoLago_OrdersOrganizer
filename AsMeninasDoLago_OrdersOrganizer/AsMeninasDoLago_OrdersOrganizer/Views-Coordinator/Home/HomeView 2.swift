//
//  HomeView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = APIViewModel()
    
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	
    @Binding var showOrderDetails: Bool
    @Binding var orderData: OrderJSON?
	
    @State var orders = [
		OrderJSON(name: "Rodrigo", totalValue: 10.00),
		OrderJSON(name: "Rafael", totalValue: 50.00),
		OrderJSON(name: "Roger", totalValue: 50.00),
		OrderJSON(name: "Aline", totalValue: 50.00)
	]
	
    init(showOrderDetails: Binding<Bool>, orderData: Binding<OrderJSON?>) {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
        self._showOrderDetails = showOrderDetails
        self._orderData = orderData
	}
	
	var body: some View {
			VStack {
				NavBar(title: "Comandas")
				
				SearchBar(searchText: $searchText)
				Divider()
					.padding(.top, 8)
					.padding(.horizontal)
				
				ScrollView {
                    HomeOrdersCollectionView(data: orders, showOrderDetails: $showOrderDetails, dataToBeShown: $orderData, searchText: $searchText)
				}
				Spacer()
				
				NavigationLink(
					destination: NewOrderView(),
					isActive: $isShowingNewOrderView,
					label: { EmptyView() })
				
				BigButton(text: "Nova comanda") {
					isShowingNewOrderView = true
				}
				Spacer(minLength: 160)
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                vm.getOpenOrders()
                DispatchQueue.main.async {
                    if !vm.openOrders.isEmpty {
                        orders = vm.openOrders
                    }
                }
            })
	}
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


