//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
	@State var searchText = ""
	
    var body: some View {
		VStack {
			navBar(title: "Comandas")
			searchBar(searchText: $searchText)
			Spacer()
			LinearGradient(gradient: Gradient(colors: [Color(.appGreen), .white]), startPoint: .topLeading, endPoint: .trailing)
		}
    }
}

private struct navBar: View {
	var title: String
	var body: some View {
		HStack {
			Text(title)
				.bold()
				.font(.title)
				.padding(.horizontal)
			
			Spacer()
		}
	}
}

private struct searchBar: View {
	@Binding var searchText: String
	@State var isSearching = false
	
	var body: some View {
		HStack {
			HStack {
				TextField("Pesquisar", text: $searchText)
					.padding(.leading, 30)
			}.padding()
			.background(Color(.systemGray4))
			.cornerRadius(20)
			.padding(.horizontal)
			.onTapGesture(perform: {
				isSearching = true
			})
			.overlay(
				HStack {
					Image(systemName: "magnifyingglass")
					Spacer()
					
					if isSearching {
						Button(action: {
							searchText.removeAll()
						}, label: {
							Image(systemName: "xmark.circle.fill")
								.padding(.vertical)
						})
					}
				}.padding(.horizontal, 32)
				.foregroundColor(.gray)
			).transition(.move(edge: .trailing))
			.animation(.spring())
			
			if isSearching {
				Button(action: {
					isSearching = false
					searchText.removeAll()
					
					UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
				}, label: {
					Text("Cancelar")
						.padding(.vertical)
						.padding(.trailing)
						.padding(.leading, 0)
				})
				.transition(.move(edge: .trailing))
				.animation(.spring())
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
