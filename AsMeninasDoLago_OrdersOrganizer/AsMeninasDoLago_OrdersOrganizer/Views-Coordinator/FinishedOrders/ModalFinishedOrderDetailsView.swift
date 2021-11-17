//
//  ModalFinishedOrderDetailsView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/11/21.
//

import SwiftUI

struct ModalFinishedOrderDetailsView: View {
	@Environment(\.presentationMode) var presentation
	
	// Dummy data
	var data: [testData] = dataa
	@Binding var testData: OrderJSON
	@Binding var selectedModal: ContentView.Modals
	
	@State var op: CGFloat = -100
	
	var body: some View {
		ZStack (alignment: .topLeading) {
			VStack (alignment: .leading) {
				ZStack (alignment: .leading) {
					
					Text(testData.name ?? "Cliente")
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
				ScrollView {
					LazyVStack {
						ForEach(data, id: \.self) { el in
							FinishedOrderDetailsCell(item: el)
						}
					}
				}
				
				VStack {
					Divider()
					
					Text("Total: " + ((testData.totalValue ?? 0).asCurrencyBR() ?? 0.00.asCurrencyBR()!))
						.font(.title3)
						.fontWeight(.bold)
						.frame(maxWidth: .infinity, alignment: .trailing)
						.padding(.horizontal)
						.padding(.top, 10)
						.padding(.bottom, 25)
					
				}
				.frame(minWidth: 0, maxWidth: .infinity)
			}
			.background(Color.white)
		}
	}
}

struct FinishedOrderDetailsCell: View {
	var item: testData
	
	var body: some View {
		VStack {
			HStack {
				Text(item.qtd)
					.fontWeight(.bold)
					.font(.title)
					+ Text("x")
					.fontWeight(.light)
				
				Image(systemName: item.img)
					.resizable()
					.scaledToFit()
					.frame(minHeight: 50, idealHeight: 75, maxHeight: 75)
				//.frame(height: 75)
				
				VStack (alignment: .leading, spacing: 5) {
					Text(item.nome)
						.fontWeight(.bold)
						.lineLimit(3)
					
					Text (item.preco.asCurrencyBR() ?? 0.00.asCurrencyBR()!)
						.padding(.top)
				}
				
				Spacer()
				
			}
			.padding(.vertical, 10)
			
			Divider()
			
		}
		.padding(.horizontal, 20)
	}
}

struct ModalFinishedOrderDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
