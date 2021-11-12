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
	
    @Binding var showOrderDetails: Bool
    @Binding var orderData: OrderJSON
	
	let orders = [
		OrderJSON(name: "Rodrigo", totalValue: 10.00),
		OrderJSON(name: "Rafael", totalValue: 50.00),
		OrderJSON(name: "Roger", totalValue: 50.00),
		OrderJSON(name: "Aline", totalValue: 50.00)
	]
    
//    @State var orders = [OrderJSON]()
	
    init(showOrderDetails: Binding<Bool>, orderData: Binding<OrderJSON>) {
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				  UINavigationBar.appearance().shadowImage = UIImage()
				  UINavigationBar.appearance().isTranslucent = true
				  UINavigationBar.appearance().backgroundColor = .clear
        self._showOrderDetails = showOrderDetails
        self._orderData = orderData
	}
	
	var body: some View {
			VStack {
				NavBar(title: "Comandas")
				
				SearchBar(searchText: $searchText)
				Divider()
					.padding(.top, 8)
					.padding(.horizontal)
				
				ScrollView {
                    HomeOrdersCollectionView(data: orders, showOrderDetails: $showOrderDetails, dataToBeShown: $orderData, searchText: $searchText)
				}
				Spacer()
				
				NavigationLink(
					destination: NewOrderView(),
					isActive: $isShowingNewOrderView,
					label: { EmptyView() })
				
				BigButton(text: "Nova comanda") {
					isShowingNewOrderView = true
//                    guard let url = URL(string: "https://api-grupo1.herokuapp.com/MostraCardapio") else {
//                        print("erro")
//                        return
//                    }
//                    let req = URLSession.shared.dataTask(with: url) { (data, res, err) in
//                    guard let data = data else { return }
//                    print(String(data:data, encoding: .utf8) ?? "eita")
//
//                    }
//                    req.resume()
				}
				Spacer(minLength: 160)
			}
			.background(Color.white.ignoresSafeArea())
			.navigationBarHidden(true)
			.navigationTitle("Comandas")
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                loadOrders()
            })
	}
    
    func loadOrders(){
        guard let url = URL(string: "https://api-grupo1.herokuapp.com/MostraComandasAbertas") else {
            print("Erro: URL Inválida")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([OrderJSON].self, from: data) {
                    DispatchQueue.main.async {
                        //self.orders = decodedResponse
                    }
                    return
                }
            }
            print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
        
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

