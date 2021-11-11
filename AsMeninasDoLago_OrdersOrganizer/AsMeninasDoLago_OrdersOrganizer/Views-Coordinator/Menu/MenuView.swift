//
//  MenuView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 05/11/21.
//

import SwiftUI

struct MenuView: View {
	@State var searchText = ""
	let categories = DebugHelper().createCategoryMock()
	@State private var selectedTab: String = ""
	
	@State private var showModal = false
	@State var data: ItemJSON = ItemJSON(name: nil, price: nil, image: nil)
	
    var body: some View {
		VStack {
			NavBar(title: "Cardápio")
			
			SearchBar(searchText: $searchText)

			Divider()
				.padding(.horizontal)
				.padding(.top, 8)
			
			TabMenu(tabs: categories, selectedTab: $selectedTab)
			
			Divider()
				.padding(.horizontal)
			
			Spacer()
			
			ScrollView {
				MenuCollectionView(data: categories.first(where: { $0.name == selectedTab})?.subcategories ?? [], isModalToBeShown: $showModal, dataToBeShown: $data, searchText: $searchText)
				
				Spacer(minLength: 160)
			}
		}
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
