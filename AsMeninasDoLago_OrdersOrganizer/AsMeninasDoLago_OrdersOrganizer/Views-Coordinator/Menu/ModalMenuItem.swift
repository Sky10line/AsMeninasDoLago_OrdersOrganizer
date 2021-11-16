//
//  ModalMenuItem.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/11/21.
//

import SwiftUI

struct ModalMenuItem: View {
	@Environment(\.presentationMode) var presentation
	
	var title: String
	@State private var name: String = ""
	@State private var value: String = ""
	
	@Binding var selectedModal: ContentView.Modals
//	@Binding var data: ItemJSON
	
	@State var op: CGFloat = -100
	
	enum Categories: String {
		case bebidas = "Bebidas"
		case caldos = "Caldos"
		case escondidinhos = "Escondidinhos"
		case lanches = "Lanches"
		case porcoes = "Porções"
		case salgados = "Salgados"
		case tapiocas = "Tapiocas"
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
			}
			.background(Color(UIColor.gray3))
		}
	}
}
