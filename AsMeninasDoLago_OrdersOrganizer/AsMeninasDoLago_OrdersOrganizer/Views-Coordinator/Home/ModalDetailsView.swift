//
//  ModalView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/10/21.
//

import SwiftUI

struct ModalDetailsView: View {
    
    @Environment(\.presentationMode) var presentation
    
    // Dummy data
    var data: [testData] = dataa
    @Binding var testData: OrderJSON
	@Binding var selectedModal: ContentView.Modals
    
    @State var op: CGFloat = -100
	
	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
    
    var body: some View {
            ZStack (alignment: .topLeading) {
                
//                Rectangle()
//                    .foregroundColor(Color.black)
//                    .opacity(isShowing ? 0.6 : 0)
//                    .offset(y: -100)
                   
                
                VStack (alignment: .leading) {
                    
                    // Cabeçalho com nome e botão de fechar
                    ZStack (alignment: .leading) {
                        // Nome do cliente
                        Text(testData.name )
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        // Botão de fechar
                        Button(action: { //presentation.wrappedValue.dismiss()
							selectedModal = .none
                            
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .renderingMode(.template)
                                .foregroundColor(.black)
								.opacity(0.5)
                                .font(.largeTitle)
                                
                        }
                        .padding(10)
                            
                    } // Fecha ZStack do cabeçalho
                    
                    // Table View + Scroll com a Dummy Data
                    ScrollView {
                        LazyVStack {
                            ForEach(data, id: \.self) { el in
//                                TableCell(item: el)
                            }
                            
                            // Botão de adicionar mais itens
                            BigButtonVariant(text: "Adicionar mais itens", action: { print(testData) })
                        } // Fecha LazyVStack
                    } // Fecha ScrollView
                    
                    // Bottom Menu
                    VStack {
                        Divider()
                        
                        // Valor da comanda
                        Text("Total: " + ((testData.totalValue ).asCurrencyBR() ?? 0.00.asCurrencyBR()!))
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        // Botão de Finalizar comanda
                        BigButton(text: "Finalizar comanda", action: nil)
							.padding()
                            .padding(.bottom, 25)
                    } // Fecha VStack bottom menu
                    .frame(minWidth: 0, maxWidth: .infinity)

                } // Fecha VStack geral
				.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
				.background(Color(UIColor.gray3))
                
        } // Fecha ZStack
        
    } // Fecha body

} // Fecha struct


// MARK: - Dados para teste

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
