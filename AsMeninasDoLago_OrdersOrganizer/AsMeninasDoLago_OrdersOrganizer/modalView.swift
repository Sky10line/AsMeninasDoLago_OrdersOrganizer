//
//  modalView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/10/21.
//

import SwiftUI

struct modalView: View {
    
    @Environment(\.presentationMode) var presentation
    
    // Dummy data
    var data: [testData] = dataa
    
    var body: some View {
            ZStack (alignment: .bottom) {
                VStack (alignment: .leading) {
                    
                    // Cabeçalho com nome e botão de fechar
                    ZStack (alignment: .leading) {
                        // Nome do cliente
                        Text("Nome do cliente")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        // Botão de fechar
                        Button(action: { presentation.wrappedValue.dismiss() }){
                            Image(systemName: "xmark.circle.fill")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                
                        }
                        .padding(10)
                            
                    }
                    
                    // Table View + Scroll com a Dummy Data
                    ScrollView {
                        LazyVStack {
                            ForEach(data, id: \.self) { el in
                                tableCell(item: el)
                            }
                            
                            // Botão de adicionar mais itens que sempre fica no final da table view
                            Button(action: {}){
                                Text("Adicionar mais itens")
                                    .font(.title)
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.green)
                                    
                            
                            }
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.green, lineWidth: 2))
                            .padding(.bottom, 5)
                            
                        }
                    }
                    
                    // Bottom Menu
                    VStack {
                        Divider()
                        
                        // Valor da comanda
                        Text("Total: R$ Muito")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        // Botão de Finalizar comanda
                        Button(action: {}){
                            Text("Finalizar comanda")
                                .font(.title)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                        
                        }
                        .background(Color.green)
                        .clipShape(Capsule())
                        .padding(.bottom, 50)
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                }
                
                
                
                
        }
        
    }

}

struct tableCell: View {
    var item: testData
    
    var body: some View {
        VStack {
            HStack {
                // Quantidade
                Text(item.qtd)
                    .fontWeight(.bold)
                    .font(.title)
                + Text("x")
                    .fontWeight(.light)

                // Imagem
                Image(systemName: item.img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                
                VStack (alignment: .leading, spacing: 5) {
                    // Nome do item
                    Text(item.nome)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    // Preço do item
                    Text ("R$ \(String(format: "%.2f", item.preco))")
                        .padding(.top)
                }
                
                // Pra encostar os botões no canto
                Spacer()
                
                HStack {
                    // Botão de editar
                    Button(action: {
                        print("ooooooooo")
                    }) {
                        Image(systemName: "pencil")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .font(.title)
                            
                    }
                    .padding(3)
                    
                    // Botão de deletar
                    Button(action: {
                        print("eeeeeee")
                    }){
                        Image(systemName: "trash")
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .font(.title2)
                            
                    }
                    .padding(3)
                }

            }
            .padding(.vertical, 10)
            
            // Divisória entre células
            Divider()
        }
        .padding(.horizontal, 20)
    }
        
}

struct modalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Struct da Dummy Data
struct testData: Hashable, Identifiable {
    var id = UUID()
    var img: String
    var nome: String
    var preco: Double
    var qtd: String
}

// Dummy Data
let dataa = [
    testData(img: "circle", nome: "Carne Louca", preco: 22, qtd: "3"),
    testData(img: "square", nome: "comida2", preco: 36, qtd: "1"),
    testData(img: "square", nome: "Calabresa com queijo e vinagrete", preco: 26, qtd: "1"),
    testData(img: "square", nome: "Leite condensado com coco", preco: 36, qtd: "1"),
    testData(img: "square", nome: "Long neck budweiser", preco: 36, qtd: "1"),
    testData(img: "square", nome: "Bolinhos de 3 queijos do porpeta", preco: 36, qtd: "1"),
    testData(img: "square", nome: "comida2", preco: 36, qtd: "1"),
    testData(img: "square", nome: "comida2", preco: 36, qtd: "1"),
    testData(img: "square", nome: "comida2", preco: 36, qtd: "1")
]
