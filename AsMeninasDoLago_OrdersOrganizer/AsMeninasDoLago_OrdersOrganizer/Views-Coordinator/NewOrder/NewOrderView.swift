//
//  NewOrderView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 21/10/21.
//

import SwiftUI

struct NewOrderView: View {
	@State private var name = ""
	let categories = DebugHelper().createCategoryMock()
	
	@State private var selectedTab: String = ""
    
    @State var showItemNewOrder: Bool = false
    @State var itemData: ItemJSON = ItemJSON(name: nil, price: nil, image: nil)
    
    @State var order = Order(name: "", items: [], total: 0)
    @State var showOrder: Bool = false

    var body: some View {
        ZStack {
            VStack {
                NameTextField(name: $name)
                    .padding(.top)
                
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                TabMenu(tabs: categories, selectedTab: $selectedTab)
                
                Divider()
                    .padding(.horizontal)
                
                Spacer()
                ScrollView {
                    NewOrderCollectionView(data: categories.first(where: { $0.name == selectedTab})?.subcategories ?? [], isModalToBeShown: $showItemNewOrder, dataToBeShown: $itemData)
                        .animation(.spring(response: 1, dampingFraction: 1))
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Spacer()
                    ScrollView {
                        NewOrderCollectionView(data: categories.first(where: { $0.name == selectedTab})?.subcategories ?? [], isModalToBeShown: $showItemNewOrder, dataToBeShown: $itemData)
                            .animation(.spring(response: 1, dampingFraction: 1))
                        
                    }
                    
                    
                }.background(Color.white.ignoresSafeArea())
                .navigationBarTitle("Nova comanda", displayMode: .inline)
                
            }
            
            
            if !order.items.isEmpty {
                VStack {
                    Spacer()
                    WeirdButton(text: "Comanda", action: { showOrder = true }, total: order.total)
                }.ignoresSafeArea()
                .frame(alignment: .bottom)
                
            }
            
            ZStack {
                if showItemNewOrder {
                    Rectangle()
                        .foregroundColor(Color.black)
                        .opacity(showItemNewOrder ? 0.6 : 0)
                        .ignoresSafeArea()
                        .animation(.easeIn)
            
                    ModalAddItemView(data: $itemData, isShowing: $showItemNewOrder, order: $order)
                        .padding(.top,UIScreen.main.bounds.height / 5)
                        .transition(.scale)
                        .animation(.spring())
                        .edgesIgnoringSafeArea(.all)
            
                }
                else if showOrder {
                    Rectangle()
                        .foregroundColor(Color.black)
                        .opacity(showOrder ? 0.6 : 0)
                        .ignoresSafeArea()
                        .animation(.easeIn)
                    
                    ModalCurrentOrder(testData: $order, isShowing: $showOrder)
                        .padding(.top,UIScreen.main.bounds.height / 5)
                        .transition(.scale)
                        .animation(.spring())
                        .edgesIgnoringSafeArea(.all)
                }
            }.animation(.easeInOut)
        }
    }
}

struct NameTextField: View {
	@Binding var name: String
	
	var body: some View {
		HStack {
			TextField("Nome do cliente", text: $name)
				.padding()
		}.background(Color.clear)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.black, lineWidth: 1)
		).padding(.horizontal)
	}
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView()
    }
}
