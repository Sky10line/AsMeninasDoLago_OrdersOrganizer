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
	
	@State private var showModal = false
	@Binding var data: OrderJSON
    
    @Binding var showDetailsView: Bool
	
	let orders = [
		OrderJSON(name: "Rodrigo", totalValue: 10.00),
		OrderJSON(name: "Rafael", totalValue: 50.00),
		OrderJSON(name: "Roger", totalValue: 50.00),
		OrderJSON(name: "Aline", totalValue: 50.00)
	]
	
    init(showDetailsView: Binding<Bool>, data: Binding<OrderJSON>) {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
        self._showDetailsView = showDetailsView
        self._data = data
	}
	
	var body: some View {
			ZStack {
                VStack {
                    NavBar(title: "Comandas")
                    
                    SearchBar(searchText: $searchText)
                    Divider()
                        .padding(.top, 8)
                        .padding(.horizontal)
                    
                    HomeOrdersCollectionView(data: orders.filter({ "\($0.name?.lowercased() ?? "")".contains(searchText.lowercased()) || searchText.isEmpty }), isModalToBeShown: $showDetailsView, dataToBeShown: $data)
                        
                    Spacer()
                
                    
                    NavigationLink(
                        destination: NewOrderView(),
                        isActive: $isShowingNewOrderView,
                        label: { EmptyView() })
                    
                    BigButton(text: "Nova comanda") {
                        isShowingNewOrderView = true
                    }
                    Spacer(minLength: 80)
                }
                
                
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
            //.overlay(showModal ? teste() : nil)
//			.sheet(isPresented: $showModal, content: {
//					modalDetailsView(testData: $data)
//						.ignoresSafeArea()
//				})
	}
}

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
