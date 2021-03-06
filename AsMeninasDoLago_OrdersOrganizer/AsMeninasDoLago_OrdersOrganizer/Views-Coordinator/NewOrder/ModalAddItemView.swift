//
//  ModalAddItemView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 26/10/21.
//

import SwiftUI

struct ModalAddItemView: View {
    @State private var obsText = "Observações"
    @State private var qtdItem = 0

    @State private var showAlert = false
    
    @State var value: CGFloat = 0
    
    @Binding var data: ItemJSON
    @Binding var itemImg: [String:String]
    @Binding var isShowing: Bool
    
  #if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
  
    @Binding var order: OrderJSON
    
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white
            
            VStack (alignment: .leading, spacing: 0) {
                
                // Imagem do produto
                Image(data.image ?? "LanchePlaceHolder")
					.renderingMode(.original)
                    .resizable()
					.scaledToFill()
					.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 4.5)
                    .ignoresSafeArea()
					.clipped()
                
                // Pilha vertical de nome, observações e ações
                VStack {
                    
                    Spacer()
                    // Nome do produto
                    Text(data.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    // TextField para as observações

                    TextEditor(text: $obsText)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.primary, lineWidth: 1))
                        .onTapGesture {
                            if obsText == "Observações" {
                                obsText = ""
                            }
                        }
                        .frame(maxHeight: 400)
                    
                    // Pilha horizontal com o Stepper e o botão
                    HStack {

                        
						CustomStepper(value: $qtdItem)
							.shadow(radius: 20)
						
                        // Botão de adicionar item
						BigButton(text: "Adicionar Item", action: {
                            if qtdItem > 0 {
//                                let item = OrderItem(item: data, quantity: qtdItem, comments: obsText)
                                let item = ItemInfo(nome: data.name, quantidade: qtdItem, preco: data.price, observacoes: obsText, nomeImagem: data.image!)
                                //order.items.append(item)
                                order.items.append(item)
                                order.totalValue += (data.price * Double(qtdItem))
                                itemImg[data.name] = data.image!
                                isShowing = false
                            }
                            else {
                                showAlert = true
                            }
                        })
                        .padding(.vertical)
                            
                        
                    } // Fecha HStack com Stepper e botão
                } // Fecha VStack com nome, observações e controles
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment:.bottom)
                .padding()
            } // Fecha VStack geral
            
            // Botão de fechar no topo
            Button(action: { isShowing = false }){
                Image(systemName: "xmark.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
					.opacity(0.5)
                    .font(.largeTitle)
            }.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
            .padding()
            
        } // Fecha ZStack
        .offset(y: -self.value)
        .animation(.spring())
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Atenção"), message: Text("Você não pode adicionar zero de um item a um pedido."), dismissButton: .default(Text("OK")))
        })

    } // Fecha body
} // Fecha struct

//struct ModalAddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ModalAddItemView(data: .constant(dummyCalabresa), isShowing: .constant(true), order: .constant(emptyOrder))
//
//
//    }
//}
