//
//  HomeView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 02/11/21.
//

import SwiftUI

struct HomeView: View {
	@State var searchText = ""
	@State private var isShowingNewOrderView: Bool = false
	
	@Binding var selectedModal: ContentView.Modals
    @Binding var orderData: OrderJSON
	
	let orders = [
		OrderJSON(name: "Rodrigo", totalValue: 10.00),
		OrderJSON(name: "Rafael", totalValue: 50.00),
		OrderJSON(name: "Roger", totalValue: 50.00),
		OrderJSON(name: "Aline", totalValue: 50.00),
		OrderJSON(name: "odrigo", totalValue: 10.00),
		OrderJSON(name: "afael", totalValue: 50.00),
		OrderJSON(name: "oger", totalValue: 50.00),
		OrderJSON(name: "line", totalValue: 50.00)
		
	]
	
    init(selectedModal: Binding<ContentView.Modals>, orderData: Binding<OrderJSON>) {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
        self._selectedModal = selectedModal
        self._orderData = orderData
	}
	
	var body: some View {
			VStack {
				NavBar(title: "Comandas")
				
				SearchBar(searchText: $searchText)
				Divider()
					.padding(.top, 8)
					.padding(.horizontal)
				
				ZStack(alignment: .bottom) {
					ScrollView {
						HomeOrdersCollectionView(data: orders, selectedModal: $selectedModal, dataToBeShown: $orderData, searchText: $searchText)
						
						Spacer(minLength: 280)
					}
					
					NavigationLink(
						destination: NewOrderView(),
						isActive: $isShowingNewOrderView,
						label: { EmptyView() })
					
					VStack {
						BigButton(text: "Nova comanda") {
							isShowingNewOrderView = true
						}.padding()
						.background(Color.clear)
						Rectangle().opacity(0).frame(height: 150)
					}
				}
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
	}
}

/*
struct teste: View {
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
        }
        .background(Color.blue.ignoresSafeArea())
        .edgesIgnoringSafeArea(.all)
    }
}

private struct NavBar: View {
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

private struct SearchBar: View {
	@Binding var searchText: String
	@State var isSearching = false
	
	var body: some View {
		HStack {
			HStack {
				TextField("Pesquisar", text: $searchText)
					.padding(.leading, 30)
			}.padding()
			.background(Color(UIColor.gray2))
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
				.foregroundColor(Color(UIColor.defaultPlaceholder))
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
				}).transition(.move(edge: .trailing))
				.animation(.spring())
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

