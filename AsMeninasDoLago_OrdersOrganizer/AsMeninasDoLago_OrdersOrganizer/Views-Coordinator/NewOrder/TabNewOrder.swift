//
//  TabNewOrder.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 22/10/21.
//

import SwiftUI

struct TabNewOrder: View {
	let availableTabs: [CategoryJSON]
	@Binding var selectedTab: String
	@Namespace var animation
	
	
	init(tabs: [CategoryJSON], selectedTab: Binding<String>) {
		self.availableTabs = tabs
		self._selectedTab = selectedTab
	}
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false, content: {
			HStack(spacing: 15) {
				ForEach(availableTabs, id: \.self) { tab in
					TabButton(option: tab, selectedTab: $selectedTab, animation: animation)
				}
			}.padding(.horizontal)
		}).onAppear(perform: {
			self.selectedTab = availableTabs[0].name ?? ""
		})
    }
}

private struct TabButton: View {
	var option: CategoryJSON
	@Binding var selectedTab: String
	var animation: Namespace.ID
	
	var body: some View {
		Button(action: {
			
			withAnimation(.spring()) {
				selectedTab = option.name ?? ""
			}
			
		}, label: {
			VStack(alignment: .center, spacing: 6, content: {
				Text(option.name ?? "")
					.fontWeight(.bold)
					.foregroundColor(selectedTab == (option.name ?? "") ? Color(UIColor.appGreen) : Color(UIColor.gray1))
				
				if selectedTab == option.name ?? "" {
					Capsule()
						.fill(Color(UIColor.appGreen))
						.frame(width: 60, height: 2)
						.matchedGeometryEffect(id: "TabNewOrder", in: animation)
				}
			}).frame(minWidth: 100)
		})
 }
}
