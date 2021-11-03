//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
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
						PlaceHolder1()
							.ignoresSafeArea(.all, edges: .all)
							.tag(CustomTabBar.Tabs.finishedOrders)
							.gesture(DragGesture())
							

						// Terceiro item da tab bar
						PlaceHolder2()
							.ignoresSafeArea(.all, edges: .all)
							.tag(CustomTabBar.Tabs.menu)
							.gesture(DragGesture())
						
					}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				
				CustomTabBar(selectedTab: $selectedTab)

			}.ignoresSafeArea(.keyboard, edges: .bottom)
		}.accentColor(Color(UIColor.appGreen))
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct PlaceHolder1: View {
    var body: some View {
        ZStack {
            Text("View 1")
		}
    }
}

struct PlaceHolder2: View {
    var body: some View {
        ZStack {
            Text("View 2")
        }
    }
}
