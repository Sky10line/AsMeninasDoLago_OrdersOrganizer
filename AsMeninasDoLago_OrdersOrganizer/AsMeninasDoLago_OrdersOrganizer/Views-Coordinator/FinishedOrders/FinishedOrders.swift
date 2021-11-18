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
	
	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
    var body: some View {
		VStack {
			NavBar(title: "Pedidos Finalizados")
			
			SearchBar(searchText: $searchText)

			Spacer()
//			ScrollView {
				FinishedOrdersCollectionView(data: finishedDates, selectedModal: $selectedModal, dataToBeShown: $orderData, searchText: $searchText)
				
//				Spacer(minLength: horizontalSizeClass == .regular ? UIScreen.main.bounds.height / 6 : UIScreen.main.bounds.height / 3.5)
//			}
		}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
		.padding(.top, horizontalSizeClass == .regular ? 32 : 0)
    }
}

//struct FinishedOrders_Previews: PreviewProvider {
//    static var previews: some View {
//		FinishedOrders(selectedModal: , orderData: )
//    }
//}
