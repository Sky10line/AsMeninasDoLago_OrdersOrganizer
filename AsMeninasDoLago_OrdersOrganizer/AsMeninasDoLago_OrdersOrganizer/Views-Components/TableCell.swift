//
//  TableCell.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 26/10/21.
//

import SwiftUI

struct TableCell: View {
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
                    .frame(minHeight: 50, idealHeight: 75, maxHeight: 75)
                    //.frame(height: 75)
                
                VStack (alignment: .leading, spacing: 5) {
                    // Nome do item
                    Text(item.nome)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    // Preço do item
                    Text (item.preco.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
                        .padding(.top)
                }
                
                // Pra encostar os botões no canto
                Spacer()
                
                HStack {
                    // Botão de editar
                    Button(action: {
                        print("Editar")
                    }) {
                        Image(systemName: "pencil")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .font(.title)
                            
                    }
                    .padding(3)
                    
                    // Botão de deletar
                    Button(action: {
                        print("Excluir")
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

struct TableCell_Previews: PreviewProvider {
    static var previews: some View {
        TableCell(item: testData(img: "circle", nome: "Carne Louca", preco: 22, qtd: "3"))
    }
}
