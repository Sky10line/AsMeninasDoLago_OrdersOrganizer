//
//  ModalOrder.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/11/21.
//

import SwiftUI

struct ModalOrder: View {
    
    @Binding var fullOrder: OrderJSON
    @Binding var selectedModal: ContentView.Modals
    
    var body: some View {
                
        VStack (alignment: .leading) {
            // Cabeçalho com nome e botão de fechar
            ZStack (alignment: .leading) {
                // Nome do cliente
                Text(fullOrder.name)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                        
                // Botão de fechar
                Button(action: { selectedModal = .none}) {
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .font(.largeTitle)
                    }.padding(10)
                            
                } // Fecha ZStack do cabeçalho
                    
                // Table View + Scroll com a Dummy Data
                ScrollView {
                    LazyVStack {
                        ForEach(fullOrder.items, id: \.self) { item in
                            OrderCollectionCell(selectedModal: $selectedModal, item: item)
                        }
                            
                        // Botão de adicionar mais itens
                        if selectedModal == ContentView.Modals.homeOrderDetails {
                            BigButtonVariant(text: "Adicionar mais itens", action: { print(fullOrder) })
                        }
                    } // Fecha LazyVStack
                } // Fecha ScrollView
                    
                // Bottom Menu
                VStack {
                    Divider()
                        
                    // Valor da comanda
                    Text("Total: " + ((fullOrder.totalValue ).asCurrencyBR() ?? 0.00.asCurrencyBR()!))
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, selectedModal == ContentView.Modals.homeOrderDetails ? 0 : 25)
                        
                    if selectedModal == ContentView.Modals.homeOrderDetails {
                        // Botão de Finalizar comanda
                        BigButton(text: "Finalizar comanda", action: nil)
                            .padding()
                            .padding(.bottom, 25)
                    }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity) // Fecha VStack bottom menu

                } // Fecha VStack geral
                .background(Color.white)
        
    } // Fecha body
} // Fecha struct


struct ModalOrder_Previews: PreviewProvider {
    static var previews: some View {
        ModalOrder(fullOrder: .constant(dummyOrder1), selectedModal: .constant(ContentView.Modals.homeOrderDetails))
    }
}
