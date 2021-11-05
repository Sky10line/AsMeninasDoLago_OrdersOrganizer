//
//  FinishedOrders.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct FinishedOrders: View {
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	@State private var showModal = false
	@State var data: OrderJSON = OrderJSON(name: "Placeholder", totalValue: 0).self
	
	let finishedDates = DebugHelper().createFinishedDateMock()
	
    var body: some View {
		VStack {
			NavBar(title: "Pedidos Finalizados")
			
			SearchBar(searchText: $searchText)

			Spacer()
			
			ScrollView {
				FinishedOrdersCollectionView(data: finishedDates, isModalToBeShown: $showModal, dataToBeShown: $data, searchText: $searchText)
				
				Spacer(minLength: 160)
			}
		}
    }
}

struct FinishedOrders_Previews: PreviewProvider {
    static var previews: some View {
        FinishedOrders()
    }
}
