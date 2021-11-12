//
//  ModalCurrentOrder.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 12/11/21.
//

import SwiftUI

struct ModalCurrentOrder: View {
    
    var data: [testData] = dataa
    @Binding var testData: Order
    @Binding var isShowing: Bool
    
    @State var op: CGFloat = -100
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            
            VStack (alignment: .leading) {
                
                // Cabeçalho com nome e botão de fechar
                ZStack (alignment: .leading) {
                    // Nome do cliente
                    Text(testData.name)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Botão de fechar
                    Button(action: {
                        isShowing = false
                        
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .font(.largeTitle)
                            
                    }
                    .padding(10)
                        
                } // Fecha ZStack do cabeçalho
                
                // Table View + Scroll com a Dummy Data
                ScrollView {
                    LazyVStack {
                        ForEach(testData.items, id: \.self) { el in
                            TableCell(item: el)
                        }
                    } // Fecha LazyVStack
                } // Fecha ScrollView
                
                // Bottom Menu
                VStack {
                    Divider()
                    
                    // Valor da comanda
                    Text("Total: " + (testData.total .asCurrencyBR() ?? 0.00.asCurrencyBR()!))
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Botão de Finalizar comanda
                    BigButton(text: "Enviar comanda", action: nil)
                        .padding(.bottom, 25)
                } // Fecha VStack bottom menu
                .frame(minWidth: 0, maxWidth: .infinity)

            } // Fecha VStack geral
            .background(Color.white)
            
    } // Fecha ZStack
    }
}

struct ModalCurrentOrder_Previews: PreviewProvider {
    static var previews: some View {
        //ModalCurrentOrder()
        NewOrderView()
    }
}
