//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showModal = false
    
    var body: some View {
            ZStack {
                
                // Botão auxiliar pra abrir a modal
                Button(action: {
                        showModal = true
                }, label: {
                    Text("Button")
                })
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                    
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $showModal, content: {
            modalAddItemView()
                .ignoresSafeArea()
        })
            
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
