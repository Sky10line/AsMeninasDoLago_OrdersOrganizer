//
//  HomeView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var api = ApiRequest()
    
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	
	@Binding var selectedModal: ContentView.Modals
    @Binding var orderData: OrderJSON
	
    @State var orders: [OrderJSON] = []
    @State var attempt = 0
  
    #if os(iOS)
		  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
	  #endif

    init(selectedModal: Binding<ContentView.Modals>, orderData: Binding<OrderJSON>) {
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
						
						Spacer(minLength: horizontalSizeClass == .regular ? UIScreen.main.bounds.height / 6 : UIScreen.main.bounds.height / 3.5)
					}
					
					NavigationLink(
						destination: NewOrderView(isBeingPresented: $isShowingNewOrderView),
						isActive: $isShowingNewOrderView,
						label: { EmptyView() })
					
					VStack {
						BigButton(text: "Nova comanda") {
							isShowingNewOrderView = true
						}.padding()
						.background(Color.clear)
						Rectangle().opacity(0).frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height / 8 : UIScreen.main.bounds.height / 6)
					}
				}
			}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
			.padding(.top, horizontalSizeClass == .regular ? 32 : 0)
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                asyncRepeat()
            }
            
            
	}
    
    func asyncRepeat() {
        api.getOpenOrders() {
            if !api.openOrders.isEmpty {
                orders = api.openOrders
                return
            }
            else {
                attempt += 1
                if attempt >= 5 { orders = [] ; attempt = 0 ; return }
                asyncRepeat()
            }
        }
    }
}
