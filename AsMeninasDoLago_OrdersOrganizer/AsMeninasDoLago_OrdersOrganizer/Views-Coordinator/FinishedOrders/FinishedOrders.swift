//
//  FinishedOrders.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct FinishedOrders: View {
    @ObservedObject var vm = APIViewModel()
    
	@State var searchText = ""
	@State var finishedDates = DebugHelper().createFinishedDateMock()
    
    // Modal da comanda finalizada
    @Binding var showDetails: Bool
    @Binding var orderData: OrderJSON?
	
    var body: some View {
        ZStack {
            VStack {
                NavBar(title: "Pedidos Finalizados")
                
                SearchBar(searchText: $searchText)

                Spacer()
                
                ScrollView {
                    FinishedOrdersCollectionView(data: finishedDates, isModalToBeShown: $showDetails, dataToBeShown: $orderData, searchText: $searchText)
                    
                    Spacer(minLength: 160)
                }
                
           
                
                
            }
		
		}
        .onAppear(perform: {
            vm.getFinishedOrders()
            if !vm.finishedOrders.isEmpty {
                self.finishedDates = vm.finishedOrders
            }
        })
    }
}

//struct FinishedOrders_Previews: PreviewProvider {
//    static var previews: some View {
//        //FinishedOrders(showDetails: .constant(true))
//    }
//}
