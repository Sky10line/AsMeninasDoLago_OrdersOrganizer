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
	
	@State var offsetBottomView: CGFloat = 0
	@State var lastOffsetBottomView: CGFloat = 0
	@GestureState var gestureOffset: CGFloat = 0
	
	var data: [testData] = dataa
	var totalValue: Double = 0.00
	
    var body: some View {
        ZStack {
            VStack {
                NameTextField(placeholder: "Nome do cliente", name: $name)
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
                    
                }.background(Color.white.ignoresSafeArea())
                .navigationBarTitle("Nova comanda", displayMode: .inline)
            }
            
            ZStack {
                if showItemNewOrder {
                    
					Rectangle()
						.foregroundColor(Color.black)
						.opacity(showItemNewOrder ? 0.6 : 0)
						.ignoresSafeArea()
						.animation(.easeIn)
					
                    ModalAddItemView(data: $itemData, isShowing: $showItemNewOrder)
						.cornerRadius(30)
						.padding(.top,UIScreen.main.bounds.height / 2.5)
						.transition(.move(edge: .bottom))
						.animation(.spring(response: 0.6, dampingFraction: 1))
                        .edgesIgnoringSafeArea(.all)
            
                }
			}.zIndex(2)
			.animation(.easeInOut)
			
			Rectangle()
				.foregroundColor(Color.black)
				.opacity(getBackShadow())
				.ignoresSafeArea()
				.animation(.easeIn)
			
			GeometryReader{proxy -> AnyView in
				let height = proxy.frame(in: .global).height
				
				return AnyView(
					ZStack{
						Color(UIColor.appGreen)
						
						VStack(spacing: 0) {
							Capsule()
								.fill(Color.white)
								.frame(width: 60, height: 4)
								.padding(.top, 5)
							
							ZStack {
							Text("Comanda")
								.fontWeight(.bold)
								.font(.title2)
								.foregroundColor(.white)
								
								
								HStack {
									Spacer()
									Text(totalValue.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
										.foregroundColor(.white)
										.fontWeight(.regular)
										.font(.body)
										.padding(.horizontal)
								}
							}.padding(.vertical, 10)
							.padding(.bottom, 25)
							
							Spacer()
							
							
							ScrollView {
								LazyVStack {
									ForEach(data, id: \.self) { el in
										TableCell(item: el)
									}
								}.background(Color.white)
							}
							
							BigButton(text: "Enivar comanda") {
								
							}.padding()
							.padding(.bottom, 200).background(Color.white)
							
							
							
						}.frame(maxHeight: .infinity, alignment: .top)
					}.cornerRadius(20)
					.offset(y: height - 80)
					.offset(y: -offsetBottomView > 0 ? -offsetBottomView <= (height - 80) ? offsetBottomView : -(height - 80) : 0)
					.gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
						
						out = value.translation.height
						onBottomViewChange()
					}).onEnded({ value in
						
						let maxHeight = height - 80
						withAnimation {
							if  -offsetBottomView < maxHeight / 3 {
								offsetBottomView = 0
							} else {
								offsetBottomView = -(maxHeight / 1.3)
							}
						}
						lastOffsetBottomView = offsetBottomView
					}))
				)
			}
			.ignoresSafeArea(.all, edges: .bottom)
		}
	}
	
	func onBottomViewChange() {
		DispatchQueue.main.async {
			self.offsetBottomView = gestureOffset + lastOffsetBottomView
		}
	}
	
	func getBackShadow() -> Double {
		let progress = -offsetBottomView / (UIScreen.main.bounds.height - 80)

		return Double(progress)
	}
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView()
    }
}
