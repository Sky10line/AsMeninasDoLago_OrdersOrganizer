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
    
    func loadOrders(){
        guard let url = URL(string: "https://api-grupo1.herokuapp.com/MostraCardapio") else {
            print("Erro: URL Inválida")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([OrderJSON].self, from: data) {
                    DispatchQueue.main.async {
                        //self.orders = decodedResponse
                    }
                    return
                }
            }
            print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
