//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showModal = false
    @State private var screenHeight: CGFloat = 700
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                
                    Button(action: {
                            showModal = true
                        screenHeight = geometry.size.height
                        
                    }, label: {
                        Text("Button")
                    })
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    
                    //modalView(isShowing: $showModal, maxH: $screenHeight)
                //modalView(isShowing: $showModal, parentHeight: $screenHeight)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $showModal, content: {
                modalView(isShowing: $showModal, parentHeight: $screenHeight)
                    .ignoresSafeArea()
            })
            
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
