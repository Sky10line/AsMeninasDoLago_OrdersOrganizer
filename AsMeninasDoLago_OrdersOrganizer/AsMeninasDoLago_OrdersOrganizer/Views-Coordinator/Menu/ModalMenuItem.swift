//
//  ModalMenuItem.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/11/21.
//

import SwiftUI

struct ModalMenuItem: View {
    @Environment(\.presentationMode) var presentation
    
    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var title: String
    @State private var name: String = ""
    @State private var value: String = ""
    
    @Binding var selectedModal: ContentView.Modals
    
    @State private var category: Categories = .none
    @State private var subcategory: String = ""
    
    private let subcategories: [Categories: [String]] = [.bebidas: ["Alcoólicos", "Não alcoólicos", "Sucos Detox"],
                                                          .lanches: ["Sanduíches", "HotDogs"],
                                                          .salgados: ["Tortas", "Empadas"],
                                                          .tapiocas: ["Salgados", "Doces"]]
    
    enum Categories: String {
        case bebidas = "Bebidas"
        case caldos = "Caldos"
        case escondidinhos = "Escondidinhos"
        case lanches = "Lanches"
        case porcoes = "Porções"
        case salgados = "Salgados"
        case tapiocas = "Tapiocas"
        case none = ""
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack (alignment: .leading) {
                ZStack (alignment: .leading) {
        
                    Text(title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
        
                    Button(action: {
                        selectedModal = .none
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .font(.largeTitle)
                    }
                    .padding(10)
                }
        
                NameTextField(placeholder: "Nome do item", name: $name)
        
                NameTextField(placeholder: "Valor", name: $value)
        
                Text("Categoria")
                    .fontWeight(.bold)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        buildCategory(category: .bebidas)
                        buildCategory(category: .caldos)
                        buildCategory(category: .escondidinhos)
                        buildCategory(category: .lanches)
                    }.frame(width: 200, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        buildCategory(category: .porcoes)
                        buildCategory(category: .salgados)
                        buildCategory(category: .tapiocas)
                    }
                }.padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        //ação de quando tocar em adicionar ou editar a foto
                        
                        
                    }, label: {
                        //esse código faz o layout de quando tem uma imagem carregada
                        //            ↓
//                        ZStack(alignment: .bottomTrailing) {
//                            Rectangle()
//                                .frame(width: 90, height: 90)
//                                .foregroundColor(Color(UIColor.gray3))
//
//                            ZStack(alignment: .topLeading) {
//                                Rectangle()
//                                    .frame(width: 90, height: 90)
//                                    .foregroundColor(Color(UIColor.gray3))
//
//                                Image("imagePlaceholder") //← somente precisar carregar a imagem
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 86, height: 86)
//                                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                            }
//
//                            Image(systemName: "pencil.circle.fill")
//                                .foregroundColor(Color(UIColor.appGreen))
//                                .background(Color.white.clipShape(Circle())
//                                    .frame(width: 15, height: 15))
//
//                        }
                            
                            
                        //esse código faz o layout quando não tem nenhuma imagem carregada
                        //                ↓
//                        RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.appGreen), lineWidth: 1)
//                            .foregroundColor(Color(UIColor.appGreen))
//                            .overlay(Image(systemName: "plus.circle.fill"))
//                            .frame(width: 86, height: 86)
                        
                    })
                    Spacer()
                }
                
                BigButton(text: "Salvar item") {
                    //acao de salvar item
                }.padding()
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.gray3))
        }
    }
    
    func buildCategory(category: Categories) -> some View {
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {
                    withAnimation {
                        if self.category == category {
                            self.category = .none
                            self.subcategory = ""
                        } else {
                            self.category = category
                        }
                    }
                }, label: {
                    HStack {
                        Image(systemName: self.category == category ? "checkmark.circle.fill" : self.category == .none ? "circle": "circle.fill")
                            .foregroundColor(self.category == category ? Color(UIColor.appGreen): Color(UIColor.gray1))
                        Text(category.rawValue)
                            .fontWeight(self.category == category ? .bold: .medium)
                            .foregroundColor(self.category == category ? Color(UIColor.appGreen): Color(UIColor.gray1))
                    }
                })
                
                if self.category == category {
                    if let subcategory = subcategories[category] {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(subcategory, id: \.self) { sub in
                                Button(action: {
                                    if self.subcategory == sub {
                                        self.subcategory = ""
                                    } else {
                                        self.subcategory = sub
                                    }
                                }, label: {
                                    HStack {
                                        Image(systemName: self.subcategory == sub ? "checkmark.circle.fill" : self.subcategory == "" ? "circle": "circle.fill")
                                            .foregroundColor(self.subcategory == sub ? Color(UIColor.appGreen): Color(UIColor.gray1))
                                        Text(sub)
                                            .fontWeight(self.subcategory == sub ? .bold: .medium)
                                            .foregroundColor(self.subcategory == sub ? Color(UIColor.appGreen): Color(UIColor.gray1))
                                    }
                                })
                            }
                        }.padding(.leading)
    //                    .transition(.opacity.combined(with: .move(edge: .top).animation(.easeIn(duration: 0.3))))
                    }
                }
            
        }
    }
}

struct ModalMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        ModalMenuItem(title: "Item", selectedModal: .constant(ContentView.Modals.editMenuItem))
    }
}

