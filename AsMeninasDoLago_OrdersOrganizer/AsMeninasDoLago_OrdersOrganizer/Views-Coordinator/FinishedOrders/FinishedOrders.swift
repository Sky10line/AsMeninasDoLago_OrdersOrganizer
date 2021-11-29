//
//  FinishedOrders.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct FinishedOrders: View {
    @ObservedObject var api = ApiRequest()
    
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	
	@Binding var selectedModal: ContentView.Modals
	@Binding var orderData: OrderJSON
	
	@State var finishedDates = DebugHelper().createFinishedDateMock()
	
	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
	
    var body: some View {
		VStack {
			NavBar(title: "Pedidos Finalizados")
			
			SearchBar(searchText: $searchText)

			Spacer()
			
			RefreshableScroll {
				FinishedOrdersCollectionView(data: $finishedDates, selectedModal: $selectedModal, dataToBeShown: $orderData, searchText: $searchText)
				
				Spacer(minLength: horizontalSizeClass == .regular ? UIScreen.main.bounds.height / 6 : UIScreen.main.bounds.height / 3.5)
			} onRefresh: { control in
				api.getFinishedOrders() {
					finishedDates = api.finishedOrders
					control.endRefreshing()
				}
			}
		}
        .padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
		.padding(.top, horizontalSizeClass == .regular ? 32 : 0)
        .onAppear() {
            api.getFinishedOrders() {
                finishedDates = api.finishedOrders
            }
        }
        
    }
}


//struct FinishedOrders_Previews: PreviewProvider {
//    static var previews: some View {
//        FinishedOrders(selectedModal: .constant(ContentView.Modals.finishedOrderDetails), orderData: .constant(dummyOrder1))
//    }
//}
