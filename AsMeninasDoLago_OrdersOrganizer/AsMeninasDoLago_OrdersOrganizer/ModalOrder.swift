//
//  ModalOrder.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/11/21.
//

import SwiftUI

struct ModalOrder: View {
    @ObservedObject var api = ApiRequest()
    
    @Binding var fullOrder: OrderJSON
    @Binding var selectedModal: ContentView.Modals
	@Binding var itemToEdit: ItemInfo
	
    @State var showAlert = false
    @State var itemToRemove: ItemInfo? = nil
    var ih: [String: String] = [:]
	var isFinishedOrders: Bool
    
    @State var attempt = 0
    
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
							OrderCollectionCell(selectedModal: $selectedModal, item: item, itemImg: ih, isFinishedOrders: isFinishedOrders, deleteAction: {
                                showAlert = true
                                itemToRemove = item
							}, editAction: {
								itemToEdit = item
								selectedModal = .editOpenOrderItem
							})
                        }
                            
                        // Botão de adicionar mais itens
//                        if selectedModal == ContentView.Modals.homeOrderDetails {
//                            BigButtonVariant(text: "Adicionar mais itens", action: { print(fullOrder) })
//                        }
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
                        BigButton(text: "Finalizar comanda", action: {
                            asyncRepeat()
                        })
                            .padding()
                            .padding(.bottom, 25)
                    }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity) // Fecha VStack bottom menu

                } // Fecha VStack geral
                .background(Color.white)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Deseja mesmo excluir esse item? Essa ação não poderá ser desfeita"), primaryButton: .cancel(Text("Voltar")), secondaryButton: .destructive(Text("Excluir"), action: {
							if let id = fullOrder.id {
								if fullOrder.items.count == 1 {
									api.getCancelOrder(for: id) {
										selectedModal = .none
									}
								} else {
									api.getRemoveItemOpenOrder(for: id, item: itemToRemove!){
										api.getOpenOrders {
											self.fullOrder = api.openOrders.first(where: { $0.id == fullOrder.id }) ?? api.openOrders[0]
										}
									}
								}
							}
                        }))
                    })
		.onAppear(perform: {
//			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				api.getOpenOrders {
					self.fullOrder = api.openOrders.first(where: { $0.id == fullOrder.id }) ?? api.openOrders[0]
				}
//			}
		})
    } // Fecha body
    
    func asyncRepeat() {
		if let id = fullOrder.id {
        api.getEndOrder(for: id) { http in
            print(fullOrder.items[0].nome)
            if http.statusCode == 500 {
                attempt += 1
                if attempt >= 10 { print("Tentei demais") ; attempt = 0 ; return }
                asyncRepeat()
            }
            else {
                api.getOpenOrders {}
                api.getFinishedOrders {}
                selectedModal = .none
            }
        }
	}
        
//        api.getOpenOrders() {
//            if !api.openOrders.isEmpty {
//                orders = api.openOrders
//                return
//            }
//            else {
//                attempt += 1
//                if attempt >= 5 { orders = [] ; attempt = 0 ; return }
//                asyncRepeat()
//            }
//        }
    }
} // Fecha struct


//struct ModalOrder_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalOrder(fullOrder: .constant(dummyOrder1), selectedModal: .constant(ContentView.Modals.homeOrderDetails))
//    }
//}
