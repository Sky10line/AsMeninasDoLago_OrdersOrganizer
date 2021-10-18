//
//  modalView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/10/21.
//

import SwiftUI

struct modalView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
            ZStack (alignment: .bottom) {
                VStack (alignment: .leading) {
                    Button(action: { presentation.wrappedValue.dismiss()
                    }, label: {
                        Label("", systemImage: "xmark.circle")
                    })
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack (alignment: .leading) {
//                            ForEach(1...30, id: \.self){
//                                Text("Olá \($0)")
//                            }
                            tableView
                        }
                    })
                
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(Color.green)
        }
    }
    
    var tableView: some View {
        ZStack {
            VStack {
                ForEach(Range(1...10)){_ in
                    tableCell
                }
                
            }
        }
    }
    
    var tableCell: some View {
        HStack {
            Text("Qtd")
            
            Image(systemName: "square")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            VStack (alignment: .leading, spacing: 5) {
                Text("Nome da comida")
                    .fontWeight(.bold)
                    .lineLimit(2)
                Text ("Preço da comida")
            }
            
            
        }
    }
    

}

struct modalView_Previews: PreviewProvider {
    static var previews: some View {
        //modalView(isShowing: .constant(true))
        ContentView()
    }
}



struct testData {
    var img: String
    var nome: String
    var preco: String
    var qtd: String
}

let data = [testData(img: "circle", nome: "comida1", preco: "22", qtd: "3"), testData(img: "square", nome: "comida2", preco: "36", qtd: "1")]
