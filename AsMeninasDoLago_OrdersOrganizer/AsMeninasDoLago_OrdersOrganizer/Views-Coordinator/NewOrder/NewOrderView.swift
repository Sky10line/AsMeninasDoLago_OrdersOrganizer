//
//  NewOrderView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 21/10/21.
//

import SwiftUI

struct NewOrderView: View {
	@ObservedObject var api = ApiRequest()
	
	@State private var name = ""
    @State var categories = DebugHelper().createCategoryMock()
	
	@State private var selectedTab: String = ""
    
    @State var showItemNewOrder: Bool = false
    @State var itemData: ItemJSON = ItemJSON(name: "", price: 0, image: nil)
	@State var offsetBottomView: CGFloat = 0
	@State var lastOffsetBottomView: CGFloat = 0
	@GestureState var gestureOffset: CGFloat = 0
    
    @State private var showAlert = false
    @State var alertMessage = ""
    @State var isAlertDestructive = false
    @State var itemToRemove: ItemInfo? = nil
    
    @Binding var isBeingPresented: Bool
	
	//var totalValue: Double = 0.00
    
    @State var order: OrderJSON = emptyOrder
    @State var orderImgs: [String:String] = [:]
    
  
  	#if os(iOS)
		  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
	  #endif
	
	
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
			}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
			.padding(.top, horizontalSizeClass == .regular ? 32 : 0)
			
			ZStack {
				if showItemNewOrder {
					
					Rectangle()
						.foregroundColor(Color.black)
						.opacity(showItemNewOrder ? 0.6 : 0)
						.ignoresSafeArea()
						.animation(.easeIn)
					
//                    ModalAddItemView(value: $itemData, data: $showItemNewOrder, itemImg: $orderImgs, isShowing: $order)
                    ModalAddItemView(data: $itemData, itemImg: $orderImgs, isShowing: $showItemNewOrder, order: $order)
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
						Color(UIColor.white)
						
						VStack(spacing: 0) {
							HStack {
								Spacer()
								Capsule()
									.fill(Color.white)
									.frame(width: 60, height: 4)
									.padding(.top, 5)
								Spacer()
							}
							.background(Color(UIColor.appGreen))
							
							ZStack {
								Text("Comanda")
									.fontWeight(.bold)
									.font(.title2)
									.foregroundColor(.white)
								
								
								HStack {
									Spacer()
									
									Text(order.totalValue.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
										
										.foregroundColor(.white)
										.fontWeight(.regular)
										.font(.body)
										.padding(.horizontal)
								}
							}.padding(.vertical, 10)
							.padding(.bottom, 25)
							.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
							.background(Color(UIColor.appGreen))
							
							Spacer()
							
							
							ScrollView {
								LazyVStack {
                                    ForEach(order.items, id: \.self) { item in
                                        OrderCollectionCell(selectedModal: Binding.constant(ContentView.Modals.homeOrderDetails), item: item, itemImg: orderImgs, deleteAction: {
                                            alertMessage = "Deseja mesmo excluir esse item?"
                                            isAlertDestructive = true
                                            showAlert = true
                                            itemToRemove = item
                                            
                                        })
									}
								}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
								.background(Color.white)
								
							}
							
							BigButton(text: "Enviar comanda") {
                               
                                sendOrder()
							}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
							.padding()
							.padding(.bottom, UIScreen.main.bounds.height / 5).background(Color.white)
							
							
							
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
            .alert(isPresented: $showAlert, content: {
                if !isAlertDestructive {
                    return Alert(title: Text("Atenção"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                else {
                    return Alert(title: Text("Deseja mesmo excluir esse item?"), primaryButton: .cancel(Text("Voltar")), secondaryButton: .destructive(Text("Deletar"), action: {
                        order.items = order.items.filter { $0 != itemToRemove }
                       
                    }))
                }
            })
        }
        .onAppear() {
            api.getMenu() {
                categories = api.menu
            }
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
    
    func sendOrder(){
        if order.items.isEmpty {
            alertMessage = "Por favor, insira itens na comanda."
            showAlert = true
        }
        else if name == "" || name == " " {
            alertMessage = "Por favor, insira o nome do cliente"
            showAlert = true
        }
        else {
            order.name = name
            api.postNewOrder(order: order)
            isBeingPresented = false
        }
    }
	
}


//struct NewOrderView_Previews: PreviewProvider {
//	static var previews: some View {
//		NewOrderView(isBeingPresented: .constant(true))
//	}
//}
