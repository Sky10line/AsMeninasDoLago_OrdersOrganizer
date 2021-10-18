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
                    
                    // Botão de fechar
                    Button(action: { presentation.wrappedValue.dismiss()
                    }, label: {
                        Label("", systemImage: "xmark.circle")
                    })
                    .padding()
                    
                    // Table View com a Dummy Data
                    List {
                        ForEach(data, id: \.self) { el in
                            tableCell(item: el)
                        }
                        //.listRowBackground(Color.red)
                    }

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }

}

struct tableCell: View {
    var item: testData
    
    var body: some View {
        
        HStack {
            // Quantidade
            Text(item.qtd).listRowBackground(Color.red)

            // Imagem
            Image(systemName: item.img)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            VStack (alignment: .leading, spacing: 5) {
                // Nome do item
                Text(item.nome)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                // Preço do item
                Text (item.preco)

            }

        }
        .padding(.vertical, 5)
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
    var preco: String
    var qtd: String
}

// Dummy Data
let dataa = [
    testData(img: "circle", nome: "comida1", preco: "22", qtd: "3"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1"),
    testData(img: "square", nome: "comida2", preco: "36", qtd: "1")
]
