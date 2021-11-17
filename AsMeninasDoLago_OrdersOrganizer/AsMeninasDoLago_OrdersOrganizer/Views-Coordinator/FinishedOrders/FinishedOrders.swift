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
	
	@Binding var selectedModal: ContentView.Modals
	@Binding var orderData: OrderJSON
	
	let finishedDates = DebugHelper().createFinishedDateMock()
	
    var body: some View {
		VStack {
			NavBar(title: "Pedidos Finalizados")
			
			SearchBar(searchText: $searchText)

			Spacer()
			
			ScrollView {
				FinishedOrdersCollectionView(data: finishedDates, selectedModal: $selectedModal, dataToBeShown: $orderData, searchText: $searchText)
				
				Spacer(minLength: 160)
			}
		}
    }
}

//struct FinishedOrders_Previews: PreviewProvider {
//    static var previews: some View {
//		FinishedOrders(selectedModal: , orderData: )
//    }
//}
