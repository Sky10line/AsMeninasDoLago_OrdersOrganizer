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
	
    var body: some View {
		NavigationView {
			ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
					TabView(selection: $selectedTab) { // Isso é uma tab bar

						// Primeiro item da tab bar
						HomeView()
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
						
					}
					.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
					.ignoresSafeArea()
				
				CustomTabBar(selectedTab: $selectedTab)
					.padding(.bottom, horizontalSizeClass == .regular ? 32 : (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 1 > 0 ? 0 : 16))
//					.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)

			}.ignoresSafeArea(.keyboard, edges: .bottom)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.accentColor(Color(UIColor.appGreen))
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
					.previewDevice(PreviewDevice(rawValue: "iPhone 11"))
					.previewDisplayName("iPhone 11")

				ContentView()
					.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
					.previewDisplayName("iPhone 8")
	}
}
