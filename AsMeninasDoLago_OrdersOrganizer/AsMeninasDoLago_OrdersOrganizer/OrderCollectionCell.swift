//
//  OrderCollectionCell.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 16/11/21.
//

import SwiftUI

struct OrderCollectionCell: View {
    @Binding var selectedModal: ContentView.Modals
    var item: ItemInfo
    var itemImg: [String:String]
    //@Binding var clientName: String
    //@Binding var modalType: String
    let deleteAction: (() -> Void)?
    
    //@State private var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Text("\(item.quantidade)")
                    .fontWeight(.bold)
                    .font(.title)
                    + Text("x")
                    .fontWeight(.light)
                
                Image(item.nomeImagem )
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 50, idealWidth: 75, maxWidth: 75, minHeight: 50, idealHeight: 75, maxHeight: 75)
                    .clipped()
					.cornerRadius(20)
                    
                    
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(item.nome)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    
                    Text (item.preco.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
                        .padding(.top)
                }
                
                Spacer()
                
                if selectedModal == ContentView.Modals.homeOrderDetails {
                    HStack {
//                        Button(action: {
//                            print("Editar")
//                        }) {
//                            Image(systemName: "pencil")
//                                .renderingMode(.template)
//                                .foregroundColor(.black)
//                                .font(.title)
//
//                        }
//                        .padding(3)
                        
                        Button(action: {
                            deleteAction?()
                        }){
                            Image(systemName: "trash")
                                .renderingMode(.template)
                                .foregroundColor(.red)
                                .font(.title2)
                                
                        }
                        .padding(3)
                        
                    } // Fecha HStack dos botões de ação
                } // Fecha if
                
            }
            .padding(.vertical, 10)
//            .alert(isPresented: $showAlert, content: {
//                Alert(title: Text("Deseja mesmo excluir esse item?"), primaryButton: .cancel(Text("Voltar")), secondaryButton: .destructive(Text("Deletar"), action: {
//                    if modalType == "ComandaAberta" {
//                        print("batata")
//                    }
//                    else {
//                        print("Cenoura")
//                    }
//    //                api.getRemoveItemOpenOrder(for: clientName, item: item){
//    //                }
//                }))
//            })
            
            Divider()
            
        }
        .padding(.horizontal, 20)
        
    }
    
    func treatString(str: String) -> String {
        var newString: String = ""
        for character in str {
            switch character {
            case "ç":
                newString += "c"
            case "ã":
                newString += "a"
            default:
                newString += String(character)
            }
        }
        return newString
    }
    
}

//struct OrderCollectionCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderCollectionCell(selectedModal: .constant(ContentView.Modals.homeOrderDetails), item: dummyItens2[0])
//    }
//}
