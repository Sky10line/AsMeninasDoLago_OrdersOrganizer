//
//  CustomStepper.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/11/21.
//

import SwiftUI

struct CustomStepper: View {
	@Binding var value: Int
	
    var body: some View {
		
		HStack {
			
				Button(action: {
					if value > 1 {
						value -= 1
					}
				}, label: {
					Text(value > 1 ? "-" : "  ")
						.fontWeight(.light)
						.font(.title)
						.foregroundColor(.black)
						.animation(.easeIn)
				})
			
			
			Spacer()
			
			Text("\(value)")
				.fontWeight(.medium)
			
			Spacer()
			
			Button(action: {
				value += 1
			}, label: {
				Text("+")
					.fontWeight(.light)
					.font(.title)
					.foregroundColor(.black)
			})
				
		}.padding(.horizontal)
		.overlay(
			RoundedRectangle(cornerRadius: 15)
				.stroke(Color(UIColor.appGreen), lineWidth: 1)
				.frame(height: 52)
		)
		.frame(width: 150)
    }
}
