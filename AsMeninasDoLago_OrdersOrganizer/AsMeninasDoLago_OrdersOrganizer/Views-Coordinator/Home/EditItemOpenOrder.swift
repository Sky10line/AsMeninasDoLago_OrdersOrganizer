//
//  EditItemOpenOrder.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 29/11/21.
//

import SwiftUI

struct EditItemOpenOrder: View {
	@State var obsText = "Observações"
	@State var qtdItem = 1
	
	@State var value: CGFloat = 0
	
	@Binding var data: ItemInfo
	
	@Binding var selectedModal: ContentView.Modals
	
	
	#if os(iOS)
		@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	#endif
  
	@Binding var order: OrderJSON
	
	
	var body: some View {
		ZStack (alignment: .topLeading) {
			Color.white
				.onTapGesture {
					closeKeyboard()
				}
			
			VStack (alignment: .leading, spacing: 0) {
				
				// Imagem do produto
				Image(data.nomeImagem)
					.renderingMode(.original)
					.resizable()
					.scaledToFill()
					.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 4.5)
					.ignoresSafeArea()
					.clipped()
				
				// Pilha vertical de nome, observações e ações
				VStack {
					
					Spacer()
					// Nome do produto
					Text(data.nome)
						.font(.largeTitle)
						.fontWeight(.bold)
						.onTapGesture {
							closeKeyboard()
						}
					Spacer()
					
					// TextField para as observações

					TextEditor(text: $obsText)
						.padding()
						.overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.primary, lineWidth: 1))
						.onTapGesture {
							if obsText == "Observações" {
								obsText = ""
							}
						}
						.frame(maxHeight: 400)
						.onAppear() {
							// Configurar o rolê com o teclado
							NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
								let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
								let height = value.height
								
								if UIDevice.current.model == "iPad" {
									self.value = height / 1.5
								}
								else {
									self.value = height / 1.5
								}
																   
							}
															   
							NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
								self.value = 0
							}
						}
					
					// Pilha horizontal com o Stepper e o botão
					HStack {

						
						CustomStepper(value: $qtdItem)
							.shadow(radius: 20)
						
						// Botão de adicionar item
						BigButton(text: "Finalizar", action: {
								data.quantidade = qtdItem
								data.observacoes = obsText
								
                                ApiRequest().postEditItemOfOrder(for: order.id ?? -1, item: data) {
									selectedModal = .homeOrderDetails
								}
							
						})
						.padding(.vertical)
							
						
					} // Fecha HStack com Stepper e botão
				} // Fecha VStack com nome, observações e controles
				.frame(maxWidth: .infinity, maxHeight: .infinity,alignment:.bottom)
				.padding()
			} // Fecha VStack geral
			.onTapGesture {
				closeKeyboard()
			}
			
			// Botão de fechar no topo
			Button(action: { selectedModal = .homeOrderDetails }){
				Image(systemName: "xmark.circle.fill")
					.renderingMode(.template)
					.foregroundColor(Color.primary)
					.opacity(0.5)
					.font(.largeTitle)
			}.padding(.horizontal, horizontalSizeClass == .regular ? 32 : 0)
			.padding()
			
		} // Fecha ZStack
		.offset(y: -self.value)
		.animation(.spring())

	} // Fecha body
	
	private func closeKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
} // Fecha struct

//struct EditItemOpenOrder_Previews: PreviewProvider {
//	static var previews: some View {
//		ModalAddItemView(data: .constant(ItemJSON(name: "Comida", price: 10, image: "LanchePlaceHolder")), itemImg: .constant(["a":"LanchePlaceHolder"]), isShowing: .constant(true), order: .constant(OrderJSON(name: "", items: [], totalValue: 20)))
//
//
//	}
//}

