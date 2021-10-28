//
//  ContentView.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 07/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView { // Isso é uma tab bar
            
            // Primeiro item da tab bar
            CollectionHome()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Comandas")
                }
            
            // Segundo item da tab bar
            PlaceHolder1()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Pedidos finalizados")
                }
            
            // Terceiro item da tab bar
            PlaceHolder2()
                .tabItem {
                    Image(systemName: "square.grid.3x3.fill")
                    Text("Cardápio")
                }
        }
        .accentColor(Color(UIColor.appGreen)) // Cor da tab bar
        
    }
}

struct CollectionHome: View {
    @State var searchText = ""
    @State private var isShowingNewOrderView: Bool = false
    
    @State private var showModal = false
    @State var data: OrderJSON = OrderJSON(name: "Placeholder", totalValue: 0).self
    let orders = [
        OrderJSON(name: "Rodrigo", totalValue: 10.00),
        OrderJSON(name: "Rafael", totalValue: 50.00),
        OrderJSON(name: "Roger", totalValue: 50.00),
        OrderJSON(name: "Aline", totalValue: 50.00)
    ]
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                  UINavigationBar.appearance().shadowImage = UIImage()
                  UINavigationBar.appearance().isTranslucent = true
                  UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavBar(title: "Comandas")
                
                SearchBar(searchText: $searchText)
                Divider()
                    .padding(.top, 8)
                    .padding(.horizontal)
                
                HomeOrdersCollectionView(data: orders.filter({ "\($0.name?.lowercased() ?? "")".contains(searchText.lowercased()) || searchText.isEmpty }), isModalToBeShown: $showModal, dataToBeShown: $data)
                    
                Spacer()
            
                
                NavigationLink(
                    destination: NewOrderView(),
                    isActive: $isShowingNewOrderView,
                    label: { EmptyView() })
                
                BigButton(text: "Nova comanda") {
                    isShowingNewOrderView = true
                }
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationTitle("Comandas")
        }.accentColor(Color(UIColor.appGreen))
        .sheet(isPresented: $showModal, content: {
                    modalDetailsView(testData: $data)
                        .ignoresSafeArea()
                })
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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct PlaceHolder1: View {
    var body: some View {
        ZStack {
            Color.red
            Text("View 1")
        }
    }
}

struct PlaceHolder2: View {
    var body: some View {
        ZStack {
            Color.blue
            Text("View 2")
        }
    }
}
