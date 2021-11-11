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
    
    @State var showOrderDetails = false
    @State var detaislData: OrderJSON = OrderJSON(name: "Placeholder", totalValue: 0).self
	
    var body: some View {
		NavigationView {
			ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $selectedTab) { // Isso é uma tab bar

                    // Primeiro item da tab bar
                    HomeView(showOrderDetails: $showOrderDetails, orderData: $detaislData)
                        .tag(CustomTabBar.Tabs.orders)
                        .gesture(DragGesture())

                    // Segundo item da tab bar
                    FinishedOrders()
                        .tag(CustomTabBar.Tabs.finishedOrders)
                        .gesture(DragGesture())
                        

                    // Terceiro item da tab bar
                    MenuView()
                        .tag(CustomTabBar.Tabs.menu)
                        .gesture(DragGesture())
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
					.ignoresSafeArea()
				
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, horizontalSizeClass == .regular ? 32 : 0)
                
                ZStack {
                    if showOrderDetails {
                        Rectangle()
                            .foregroundColor(Color.black)
                            .opacity(showOrderDetails ? 0.6 : 0)
                            .ignoresSafeArea()
                            .animation(.easeIn)
                            
                        modalDetailsView(testData: $detaislData, isShowing: $showOrderDetails)
                            .padding(.top,UIScreen.main.bounds.height / 8)
                            .transition(.scale)
                            .animation(.spring())
                            .edgesIgnoringSafeArea(.all)
                    }
                        
                }.animation(.easeInOut)


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
