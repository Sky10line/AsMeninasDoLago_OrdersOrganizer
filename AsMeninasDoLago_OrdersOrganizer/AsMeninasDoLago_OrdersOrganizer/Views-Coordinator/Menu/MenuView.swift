//
//  MenuView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 05/11/21.
//

import SwiftUI

struct MenuView: View {
    var api = ApiRequest()
    
	@State var searchText = ""
	@State var categories = DebugHelper().createCategoryMock()
    //@State var categories: [CategoryJSON] = []
	@State private var selectedTab: String = ""
	
	@State var data: ItemJSON = dummyCalabresa
	
	@Binding var selectedModal: ContentView.Modals
	
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
			
			ZStack(alignment: .bottom) {
				ScrollView {
					MenuCollectionView(data: categories.first(where: { $0.name == selectedTab})?.subcategories ?? [], selectedModal: $selectedModal, dataToBeShown: $data, searchText: $searchText)

					Spacer(minLength: 280)
				}
				VStack {
					BigButton(text: "Adicionar item") {
						selectedModal = .addMenuItem
                        print(api.categories)
					}.padding()
					.background(Color.clear)
					Rectangle().opacity(0).frame(height: 150)
				}
			}
		}
        .onAppear() {
            api.getMenu()
            //print(api.categories)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(searchText: "", data: dummyCalabresa, selectedModal: .constant(ContentView.Modals.editMenuItem))
    }
}
