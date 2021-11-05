//
//  BigButton.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 20/10/21.
//

import Foundation
import SwiftUI

struct BigButton: View {
	let text: String
	let action: (() -> Void)?
	@State private var tap: Bool = false
	var body: some View {
		ZStack {
			Button(action: {
				tap = true
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
					tap = false
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
					action?()
				}
			}, label: {
				HStack {
					Text(text)
						.fontWeight(.bold)
						.font(.title3)
						.foregroundColor(.white)
						.padding()
				}.frame(maxWidth: .infinity)
			}).background(Color(UIColor.appGreen))
			.cornerRadius(20)
			.shadow(radius: tap ? 1 : 4)
			.animation(.spring(response: 0.6, dampingFraction: 1))
			.padding()
		}.scaleEffect(tap ? 0.9 : 1)
		.animation(.spring(response: 0.6, dampingFraction: 1))
			
	}
}

struct BigButton_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()
			BigButton(text: "Nova Comanda", action: nil)
		}
	}
}
