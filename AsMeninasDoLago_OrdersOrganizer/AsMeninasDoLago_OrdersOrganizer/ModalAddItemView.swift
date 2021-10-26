//
//  ModalAddItemView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 26/10/21.
//

import SwiftUI

struct ModalAddItemView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var obsText = "Observações"
    @State private var qtdItem = 0
    
    @State var value: CGFloat = 0
    
    // Array pra simular o recebimento de dados
    var data = ["crown","Nome do produto"]
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack (alignment: .leading, spacing: 0) {
                
                // Imagem do produto
                Image(systemName: data[0])
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(Color(UIColor.appGreen))
                    .ignoresSafeArea()
                
                
                VStack {
                    // Nome do produto
                    Text(data[1])
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
                    
                    HStack {
                        
                        // Stepper da quantidade (mais e menos)
                        // Tem um text field dentro dele que pode receber um valor digitado também
                        Stepper(value: $qtdItem, in: 0...100) {
                            //Text("\(qtdItem)")
                            TextField("\(qtdItem)", value: $qtdItem, formatter: NumberFormatter())
                                .font(.title2)
                                .onAppear {
                                    
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                                        let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                        let height = value.height
                                        if UIDevice.current.model == "iPad" {
                                            self.value = height / 6
                                        }
                                        else {
                                            self.value = height
                                        }
                                        
                                        
                                    }
                                    
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
                                        
                                        self.value = 0
                                        
                                    }
                                }
                        }
                        
                        Spacer(minLength: 10)
                        
                        // Botão de adicionar item
                        BigButton(text: "Adicionar Item", action: nil)
                            .fixedSize()
                        
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment:.top)
                .padding()
            }
            
            // Botão de fechar no topo
            Button(action: { presentation.wrappedValue.dismiss() }){
                Image(systemName: "xmark.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
                    .font(.largeTitle)
                
            }
            .padding()
            
        }
        .offset(y: -self.value)
        .animation(.spring())
    }
}

struct ModalAddItemView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Background").sheet(isPresented: .constant(true)) {
            ModalAddItemView()
        }
    }
}
