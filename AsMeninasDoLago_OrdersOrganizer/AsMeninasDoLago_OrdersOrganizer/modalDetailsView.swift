//
//  modalView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/10/21.
//

import SwiftUI

struct modalDetailsView: View {
    
    @Environment(\.presentationMode) var presentation
    
    // Dummy data
    var data: [testData] = dataa
    @Binding var testData: OrderJSON
    
    var body: some View {
            ZStack (alignment: .bottom) {
                VStack (alignment: .leading) {
                    
                    // Cabeçalho com nome e botão de fechar
                    ZStack (alignment: .leading) {
                        // Nome do cliente
                        Text(testData.name ?? "Cliente")
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
                                TableCell(item: el)
                            }
                            
                            // Botão de adicionar mais itens que sempre fica no final da table view
                            BigButtonVariant(text: "Adicionar mais itens", action: {
                            print(testData)})
                                
                        }
                    }
                    
                    // Bottom Menu
                    VStack {
                        Divider()
                        
                        // Valor da comanda
                        Text("Total: " + ((testData.totalValue ?? 0).asCurrencyBR() ?? 0.00.asCurrencyBR()!))
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        // Botão de Finalizar comanda
                        BigButton(text: "Finalizar comanda", action: nil)
                            .padding(.bottom, 25)
                        
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                }
                
                
                
                
        }
        
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
