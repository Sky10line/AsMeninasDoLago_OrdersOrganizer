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
    
    @State var value: CGFloat = 0
    
    @Binding var data: ItemJSON
    @Binding var isShowing: Bool
    
    @Binding var order: Order
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.white
            
            VStack (alignment: .leading, spacing: 0) {
                
                // Imagem do produto
                Image(data.image ?? "LanchePlaceHolder")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                
                // Pilha vertical de nome, observações e ações
                VStack {
                    
                    Spacer()
                    // Nome do produto
                    Text(data.name ?? "")
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
                        // Stepper da quantidade (mais e menos)
                        // Tem um text field dentro dele que pode receber um valor digitado também
                        Stepper(value: $qtdItem, in: 0...100) {
                            TextField("\(qtdItem)", value: $qtdItem, formatter: NumberFormatter())
                                .font(.title2)
                                .onAppear {
                                    // Configurar o rolê com o teclado
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                                        let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                        let height = value.height
                                        if UIDevice.current.model == "iPad" {
                                            self.value = height / 6
                                        }
                                        else {
                                            self.value = height / 1.1
                                        }
                                        
                                        
                                    }
                                    
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
                                        
                                        self.value = 0
                                        
                                    }
                                } // Fecha onAppear
                        } // Fecha Stepper
                        
                        // Botão de adicionar item
                        BigButton(text: "Adicionar Item", action: {
                            
                            if qtdItem == 0 {
                                showAlert = true
                                return
                            }
                            
                            order.items.append(
                                NewOrderItem(item: data, quantity: qtdItem, comments: obsText)
                            )
                            isShowing = false
                        })
                            .fixedSize()
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Atenção"), message: Text("Você precisa adicionar pelo menos 1 item."), dismissButton: .default(Text("OK")))
                        })
                        
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
            }
            .padding()
            
        } // Fecha ZStack
        .offset(y: -self.value)
        .animation(.spring())
    } // Fecha body
} // Fecha struct

struct ModalAddItemView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Background").sheet(isPresented: .constant(true)) {
//            ModalAddItemView(data: .constant(ItemJSON(name: "Carne louca", price: 20, image: "LanchePlaceHolder")), isShowing: .constant(true))
        }
    }
}
