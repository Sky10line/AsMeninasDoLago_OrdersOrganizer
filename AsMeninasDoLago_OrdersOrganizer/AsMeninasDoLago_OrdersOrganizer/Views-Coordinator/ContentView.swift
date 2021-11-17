//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
	
	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
	@State var selectedTab: CustomTabBar.Tabs = .orders
	init() {
		UITabBar.appearance().isHidden = true
	}
    
	@State var selectedModal: Modals = .none
    @State var detaislData: OrderJSON2 = dummyOrder1
	
	enum Modals {
		case homeOrderDetails
		case finishedOrderDetails
		case editMenuItem
		case addMenuItem
		case none
	}
	
    var body: some View {
		NavigationView {
			ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $selectedTab) { // Isso é uma tab bar

                    // Primeiro item da tab bar
                    HomeView(selectedModal: $selectedModal, orderData: $detaislData)
                        .tag(CustomTabBar.Tabs.orders)
                        .gesture(DragGesture())

                    // Segundo item da tab bar
                    FinishedOrders(selectedModal: $selectedModal, orderData: $detaislData)
                        .tag(CustomTabBar.Tabs.finishedOrders)
                        .gesture(DragGesture())
                        

                    // Terceiro item da tab bar
					MenuView(selectedModal: $selectedModal)
                        .tag(CustomTabBar.Tabs.menu)
                        .gesture(DragGesture())
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				.ignoresSafeArea()
				.blur(radius: selectedModal != .none ? 25 : 0)
				
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, horizontalSizeClass == .regular ? 32 : 0)
                
				ZStack(alignment: .bottom) {
					Rectangle()
						.foregroundColor(Color.black)
						.opacity(selectedModal != .none ? 0.6 : 0)
						.ignoresSafeArea()
						.animation(.easeIn)
					
					switch selectedModal {
					case .homeOrderDetails:
                        ModalOrder(fullOrder: $detaislData, selectedModal: $selectedModal)
							.cornerRadius(30)
							.padding(.top,UIScreen.main.bounds.height / 8)
							.transition(.move(edge: .bottom))
							.animation(.spring(response: 0.6, dampingFraction: 1))
							.edgesIgnoringSafeArea(.all)
						
					case .finishedOrderDetails:
                        ModalOrder(fullOrder: $detaislData, selectedModal: $selectedModal)
							.cornerRadius(30)
							.padding(.top,UIScreen.main.bounds.height / 8)
							.transition(.move(edge: .bottom))
							.animation(.spring(response: 0.6, dampingFraction: 1))
							.edgesIgnoringSafeArea(.all)
						
					case .editMenuItem:
						ModalMenuItem(title: "Editar item", selectedModal: $selectedModal)
							.cornerRadius(30)
							.padding(.top,UIScreen.main.bounds.height / 8)
							.transition(.move(edge: .bottom))
							.animation(.spring(response: 0.6, dampingFraction: 1))
							.edgesIgnoringSafeArea(.all)
						
					case .addMenuItem:
						ModalMenuItem(title: "Adicionar item", selectedModal: $selectedModal)
							.cornerRadius(30)
							.padding(.top,UIScreen.main.bounds.height / 8)
							.transition(.move(edge: .bottom))
							.animation(.spring(response: 0.6, dampingFraction: 1))
							.edgesIgnoringSafeArea(.all)
						
					case .none:
						EmptyView()
					}
                                                
				}.ignoresSafeArea()
				.animation(.easeInOut)


			}.ignoresSafeArea(.keyboard, edges: .bottom)
		}.navigationViewStyle(StackNavigationViewStyle())
		.accentColor(Color(UIColor.appGreen))
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
