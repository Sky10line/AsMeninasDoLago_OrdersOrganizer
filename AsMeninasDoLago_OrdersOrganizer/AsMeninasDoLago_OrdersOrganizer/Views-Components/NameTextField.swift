//
//  NameTextField.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/11/21.
//

import SwiftUI

struct NameTextField: View {
	var placeholder: String
	@Binding var name: String
	
	var body: some View {
		HStack {
			TextField(placeholder, text: $name)
				.padding()
		}.background(Color.white)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.black, lineWidth: 1)
		).padding(.horizontal)
	}
}
