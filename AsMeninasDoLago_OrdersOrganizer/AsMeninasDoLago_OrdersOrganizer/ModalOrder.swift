//
//  ModalOrder.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/11/21.
//

import SwiftUI


enum modalEditType {
    /// Pra comandas abertas na modal de detalhes
    case openOrder
    /// Pra comandas aberta na modal de novas comandas
    case notOpened
    /// Outras modais, como o de comandas finalizadas
    case noEdit
}

struct ModalOrder: View {
    @ObservedObject var vm = APIViewModel()
    
    @State var fullOrder = Order(name: "Eu", items: [NewOrderItem(item: ItemJSON(name: "Eu", price: 10, image: nil), quantity: 2, comments: "Sem sal")], total: 0)
    
    @State var editType: modalEditType
    
    @Binding var isShowing: Bool
    @Binding var basicOrder: OrderJSON?
    @Binding var currentOrder: Order?
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack (alignment: .leading) {
                
                // Cabeçalho com nome e botão de fechar
                ZStack (alignment: .leading) {
                    // Nome do cliente
                    Text(fullOrder.name)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    //Botão de fechar
                    Button(action: { isShowing = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .font(.largeTitle)
                        }.padding(10)
                } // Fecha ZStack do cabeçalho
                
                // TableView com ScrollView e dados
                ScrollView {
                    LazyVStack {
                        ForEach(fullOrder.items, id: \.self) { el in
                            TableCell(item: el, isEditActive: editType == modalEditType.noEdit ? false : true, removeAction: nil)
                        }
    
                        // Botão de adicionar mais itens
                        if editType == modalEditType.openOrder {
                            BigButtonVariant(text: "Adicionar mais itens", action: { print(fullOrder) })
                        }
                    } // Fecha LazyVStack
                } // Fecha ScrollView
                
                // Bottom Menu
                VStack {
                    Divider()
                
                    // Valor da comanda
                    Text("Total: " + (fullOrder.total.asCurrencyBR() ?? 0.00.asCurrencyBR()!))
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, editType == modalEditType.noEdit ? 25 : 0)
                    
                    if editType == modalEditType.openOrder {
                        // Botão de Finalizar comanda
                        BigButton(text: "Finalizar comanda", action: nil)
                            .padding(.bottom, 25)
                    }
                    else if editType == modalEditType.notOpened {
                        // Botão de Finalizar comanda
                        BigButton(text: "Enviar comanda", action: nil)
                            .padding(.bottom, 25)
                    }
                //
                //
                } .frame(minWidth: 0, maxWidth: .infinity) // Fecha VStack bottom menu
                
            }.background(Color.white) // Fecha VStack
        } // Fecha ZStack
        .onAppear() {
            if editType == modalEditType.openOrder {
                vm.getFullOrder(name: basicOrder!.name!)
                DispatchQueue.main.async {
                    if vm.fullOrder != nil {
                        fullOrder = vm.fullOrder!
                    }
                }
            }
            if editType == modalEditType.noEdit {
                // Fazer get dos dados da comanda finalizada
            }
            
            
        }
    }
    

}

//struct ModalOrder_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("Background").sheet(isPresented: .constant(true)){
//            ModalOrder(editType: modalEditType.openOrder, isShowing: .constant(true), basicOrder: .constant(nil), currentOrder: .constant(nil))
//        }
//    }
//}
