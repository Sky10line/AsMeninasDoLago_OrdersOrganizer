//
//  CustomTabBar.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct CustomTabBar: View {
	@Binding var selectedTab: Tabs
	@State var tabPoints: [CGFloat] = []
	
	enum Tabs: String {
		case orders = "OrdersTabImg"
		case finishedOrders = "FinishedOrdersTabImg"
		case menu = "MenuTabImg"
	}
	
    var body: some View {
		ZStack {
		HStack(spacing: 0) {
			TabBarButton(image: Tabs.orders.rawValue, selectedTab: $selectedTab, tabPoints: $tabPoints)
			
			TabBarButton(image: Tabs.finishedOrders.rawValue, selectedTab: $selectedTab, tabPoints: $tabPoints)
			
			TabBarButton(image: Tabs.menu.rawValue, selectedTab: $selectedTab, tabPoints: $tabPoints)
		}.padding()
		.background(
			Color(UIColor.gray3)
				.clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
		)
		.overlay(
			Circle()
				.foregroundColor(Color(UIColor.appGreen))
				.frame(width: 10, height: 10)
				.offset(x: getCurvePoint() - 20)

			,alignment: .bottomLeading
		)
		.cornerRadius(30)
		.padding(.horizontal)
		.shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
		.shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
		}
    }
	
	func getCurvePoint() -> CGFloat {
		if tabPoints.isEmpty {
			return 0
		} else {
			switch selectedTab {
			case .orders:
				return tabPoints[2]
			case .finishedOrders:
				return tabPoints[1]
			case .menu:
				return tabPoints[0]
			}
		}
	}
}

struct TabBarButton: View {
	
	var image: String
	@Binding var selectedTab: CustomTabBar.Tabs
	@Binding var tabPoints: [CGFloat]
	
	var body: some View {
		GeometryReader {reader -> AnyView in
			
			let midX = reader.frame(in: .global).midX
			
			DispatchQueue.main.async {
				if tabPoints.count <= 3 && midX != 0 {
					tabPoints.append(midX)
				}
			}
			
			return AnyView (
				Button(action: {
					withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
						if let tab = CustomTabBar.Tabs(rawValue: image) {
							selectedTab = tab
						}
					}
				}, label: {
					Image(image)
						.font(.system(size: 25, weight: .semibold))
						.foregroundColor(selectedTab.rawValue == image ? Color(UIColor.appGreen) : Color(UIColor.gray1))
						.offset(y: selectedTab.rawValue == image ? -10 : 0)
				})
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			)
		}
		.frame(height: 45)
	}
}

struct CustomTabbar_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
