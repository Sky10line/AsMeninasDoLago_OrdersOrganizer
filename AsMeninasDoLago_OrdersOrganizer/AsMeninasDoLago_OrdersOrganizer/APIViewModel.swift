//
//  APIViewModel.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 15/11/21.
//

import Foundation

class APIViewModel: ObservableObject {
    @Published var fullOrder: Order? = nil
    @Published var openOrders: [OrderJSON] = []
    @Published var menu: [CategoryJSON] = []
    @Published var finishedOrders: [FinishedDatesJSON] = []
    
    let decoder = JSONDecoder()
    
    private func createRequest(endpoint: String) -> URLRequest? {
        guard let url = URL(string: "https://api-grupo1.herokuapp.com\(endpoint)") else {
            print("Erro: URL Inválida")
            return nil
        }
        
       return URLRequest(url: url)
    }
    
    /// GET para //MostraComandaPorNome/ string:Nome
    func getFullOrder(name: String) {
        guard let request = createRequest(endpoint: "/MostraComandaPorNome/\(name)") else {
                print("Erro ao crir request")
                return
    
            }
    
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data else { return }
            if let decodedResponse = try? decoder.decode(Order.self, from: data) {
                DispatchQueue.main.async {
                    self.fullOrder = decodedResponse
                }
                return
            }
            
            print("Falha: \(error?.localizedDescription ?? "Erro desconhecido")")
        }.resume()
    }
    
    /// GET para /MostraComandasAbertas
    func getOpenOrders(){
        guard let request = createRequest(endpoint: "/MostraComandasAbertas") else {
            print("Erro ao criar request")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let decodedResponse = try? JSONDecoder().decode([OrderJSON].self, from: data) {
                DispatchQueue.main.async {
                    self.openOrders = decodedResponse
                }
                return
            }
              
            print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
    }
    
    /// GET para /MostraCardapio
    func getMenu(){
        guard let request = createRequest(endpoint: "/MostraCardapio") else {
            print("Erro ao criar request")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let decodedResponse = try? JSONDecoder().decode([CategoryJSON].self, from: data) {
                DispatchQueue.main.async {
                    self.menu = decodedResponse
                }
                return
            }
              
            print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
    }
    
    /// GET para /MostraFinalizadas
    func getFinishedOrders(){
        guard let request = createRequest(endpoint: "/MostraFinalizadas") else {
            print("Erro ao criar request")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let decodedResponse = try? JSONDecoder().decode([FinishedDatesJSON].self, from: data) {
                DispatchQueue.main.async {
                    self.finishedOrders = decodedResponse
                }
                return
            }
              
            print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
    }
    
    /// GET para /RemoveDaComanda/string:Nome/string:Item
    func removeItemFromOrder(name: String, item: String){
        guard let request = createRequest(endpoint: "/RemoveDaComanda/\(name)/\(item)") else {
            print("Erro ao criar request")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
//            if let decodedResponse = try? JSONDecoder().decode([FinishedDatesJSON].self, from: data) {
//                DispatchQueue.main.async {
//                    self.finishedOrders = decodedResponse
//
//                }
//                return
//            }
            fatalError("Eu não sei o que retorna aqui")
            //print("Falha: \(String(describing: error?.localizedDescription))")
        }.resume()
    }
    
}
