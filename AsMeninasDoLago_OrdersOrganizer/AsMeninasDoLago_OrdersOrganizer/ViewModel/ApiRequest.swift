//
//  ApiRequest.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 17/11/21.
//

import Foundation

class ApiRequest: ObservableObject {
    @Published var openOrders: [OrderJSON2] = []
    @Published var menu: Cardapio? = nil
    @Published var orderByName: OrderJSON = emptyOrder
    @Published var finishedOrders: [FinishedDatesJSON] = []
    
    let session = URLSession.shared
    let baseURL = "https://api-grupo1.herokuapp.com/"
    let decoder = JSONDecoder()
    
    private func createRequest(endpoint: String) -> URLRequest? {
        guard let url = URL(string: self.baseURL + endpoint) else {
            print("Erro: URL inválida")
            return nil
        }
        return URLRequest(url: url)
        
    }
    
    // MARK: - Funções usando GET
    
    
    
    // MARK: getOpenOrders
    // Retorna um array com todas as comandas abertas
    /// Faz chamada GET para MostraComandasAbertas
    func getOpenOrders(completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "MostraComandasAbertas") else {
            print("Erro ao criar request")
            return
        }
        
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decodedResponse = try self.decoder.decode([OrderJSON2].self, from: data)
                    
                    // Linha de testes, por favor não apagar
                    //self.openOrders = dummyCollection
                    
                    self.openOrders = decodedResponse
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                }
                catch {
                    print("Erro: \(error.localizedDescription)")
                }
            }
            
        }.resume()

       

    }
    
    // MARK: getMenu
    // Retorna o cardápio
    /// Faz chamada GET para MostraCardapio
    func getMenu(completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "MostraCardapio") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decodedResponse = try self.decoder.decode(Cardapio.self, from: data)
                    self.menu = decodedResponse
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                }
                catch {
                    print("Erro: \(error.localizedDescription)")
                }
            }
            
        }.resume()

    }
    
    // MARK: getOrderByName
    // Retorna um pedido específico puxado pelo nome
    /// Faz chamada GET para MostraComandaPorNome/{nome}
    func getOrderByName(name: String, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "MostraComandaPorNome/\(name)") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decodedResponse = try self.decoder.decode(OrderJSON.self, from: data)
                    self.orderByName = decodedResponse
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                catch {
                    print("Erro: \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }
    
    // MARK: getFinishedOrders
    // Retorna um array com as comandas finalizadas
    /// Faz chamada GET para MostraFinalizadas
    func getFinishedOrders(completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "MostraFinalizadas") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decodedResponse = try self.decoder.decode([FinishedDatesJSON].self, from: data)
                    self.finishedOrders = decodedResponse
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                catch {
                    print("Erro: \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }
    
    // MARK: getFinishOrder
    // Em teoria, não retorna nada
    /// Faz chamada GET para Finaliza/{nome}
    func getFinishOrder(for name: String, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "Finaliza/\(name)") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//                    let decodedResponse = try self.decoder.decode([FinishedDatesJSON].self, from: data)
//                    self.finishedOrders = decodedResponse
                    
//                    DispatchQueue.main.async {
                        completion()
//                    }
//                }
//                catch {
//                    print("Erro: \(error.localizedDescription)")
//                }
            }
            
        }.resume()
    }
    
    // MARK: getRemoveItemOpenOrder
    // Em teoria, não retorna nada
    /// Faz chamada GET para RemoveDaComanda/{nome}/{item}
    func getRemoveItemOpenOrder(for name: String, item: ItemJSON, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "RemoveDaComanda/\(name)/\(item.name)") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//                    let decodedResponse = try self.decoder.decode([FinishedDatesJSON].self, from: data)
//                    self.finishedOrders = decodedResponse
                    
//                    DispatchQueue.main.async {
                        completion()
//                    }
//                }
//                catch {
//                    print("Erro: \(error.localizedDescription)")
//                }
            }
            
        }.resume()
    }
    
    // MARK: getRemoveItemOpenOrder
    // Em teoria, não retorna nada
    /// Faz chamada GET para RemoveDoCardapio/{item}
    func getRemoveItemMenu(item: ItemJSON, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "RemoveDoCardapio/\(item.name)") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//                    let decodedResponse = try self.decoder.decode([FinishedDatesJSON].self, from: data)
//                    self.finishedOrders = decodedResponse
                    
//                    DispatchQueue.main.async {
                        completion()
//                    }
//                }
//                catch {
//                    print("Erro: \(error.localizedDescription)")
//                }
            }
            
        }.resume()
    }
    
    // MARK: getCancelOrder
    // Em teoria, não retorna nada
    /// Faz chamada GET para LimparComanda/{nome}
    func getCancelOrder(for name: String, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "LimparComanda/\(name)") else {
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//                    let decodedResponse = try self.decoder.decode([FinishedDatesJSON].self, from: data)
//                    self.finishedOrders = decodedResponse
                    
//                    DispatchQueue.main.async {
                        completion()
//                    }
//                }
//                catch {
//                    print("Erro: \(error.localizedDescription)")
//                }
            }
            
        }.resume()
    }
    
    
    // MARK: - Funções usando POST
    
    
    
    // MARK: postNewOrder
    // Retorna resposta HTTP
    /// Faz chamada POST para Pedido
    func postNewOrder(order: OrderJSON) {
        guard var request = createRequest(endpoint: "Pedido") else {
            print("Erro ao criar request")
            return
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        var orderForPost: [String : Any] = [
            "Nome" : order.name,
            "Total": order.totalValue
        ]
        
        var itens: [[String: Any]] = []
        
        order.items.forEach({
            let dict: [String: Any] = [
                "Nome": $0.item.name,
                "Quantidade": $0.quantity,
                "Preco": $0.item.price,
                "Observacoes": $0.comments == "Observações" || $0.comments == "" || $0.comments == " " ? "Nenhuma Observação" : $0.comments!
            ]
            itens.append(dict)
        })
        
        orderForPost["Itens"] = itens
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: orderForPost, options: [])
            session.uploadTask(with: request, from: jsonData) { data, response, error in
                if let data = data, let httpResponse = response {
                    print(data as Any)
                    print(httpResponse as Any)
                }
            }.resume()
        }
        catch {
            print("Erro: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: postChangeOpenOrderByName
    // Retorna resposta HTTP
    /// Faz chamada POST para AddNaComanda/{nome}
    func postChangeOpenOrderByName(for name: String, item: OrderItem) {
        guard var request = createRequest(endpoint: "AddNaComanda/\(name)") else {
            print("Erro ao criar request")
            return
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")



        let orderForPost: [String : Any] = [
            "Nome": item.item.name,
            "Quantidade": item.quantity,
            "Preco": item.item.price,
            "Observacoes": item.comments == "Observações" || item.comments == "" || item.comments == " " ? "Nenhuma Observação" : item.comments!
        ]


        do {
            let jsonData = try JSONSerialization.data(withJSONObject: orderForPost, options: [])
            session.uploadTask(with: request, from: jsonData) { data, response, error in
                if let data = data, let httpResponse = response {
                    print(data as Any)
                    print(httpResponse as Any)
                }
            }.resume()
        }
        catch {
            print("Erro: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: postAddItemToMenu
    // Retorna resposta HTTP
    /// Faz chamada POST para AddNoCardapio
    func postAddItemToMenu(for name: ItemJSON) {
//        guard var request = createRequest(endpoint: "AddNoCardapio") else {
//            print("Erro ao criar request")
//            return
//        }
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//
//        var orderForPost: [String : Any] = [
//            "Nome" : order.name,
//            "Total": order.totalValue
//        ]
//
//        var itens: [[String: Any]] = []
//
//        order.items.forEach({
//            let dict: [String: Any] = [
//                "Nome": $0.item.name,
//                "Quantidade": $0.quantity,
//                "Preco": $0.item.price,
//                "Observacoes": $0.comments == "Observações" || $0.comments == "" || $0.comments == " " ? "Nenhuma Observação" : $0.comments!
//            ]
//            itens.append(dict)
//        })
//
//        orderForPost["Itens"] = itens
//
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: orderForPost, options: [])
//            session.uploadTask(with: request, from: jsonData) { data, response, error in
//                if let data = data, let httpResponse = response {
//                    print(data as Any)
//                    print(httpResponse as Any)
//                }
//            }.resume()
//        }
//        catch {
//            print("Erro: \(error.localizedDescription)")
//        }
//
    }
    
    
    
    
}
