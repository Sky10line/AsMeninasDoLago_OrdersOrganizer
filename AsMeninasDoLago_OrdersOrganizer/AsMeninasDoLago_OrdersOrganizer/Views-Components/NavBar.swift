//
//  NavBar.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct NavBar: View {
	var title: String
	var body: some View {
		HStack {
			Text(title)
				.bold()
				.font(.largeTitle)
				.padding(.horizontal)
				.foregroundColor(.black)
			
			Spacer()
		}
	}
}
