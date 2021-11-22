//
//  ApiRequest.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Caroline Viana on 17/11/21.
//

import Foundation

class ApiRequest: ObservableObject {
    @Published var openOrders: [OrderJSON] = []
    @Published var menu: [CategoryJSON] = []
    @Published var orderByName: OrderJSON = emptyOrder
    @Published var finishedOrders: [FinishedDatesJSON] = []
    
    let session = URLSession.shared
    let baseURL = "https://api-grupo1.herokuapp.com/"
    let decoder = JSONDecoder()
    
    private func createRequest(endpoint: String) -> URLRequest? {
        let endpoint = endpoint.replacingOccurrences(of: " ", with: "%20")
        print(endpoint)
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
    
    // MARK: Tá funcionando
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
                    let decodedResponse = try self.decoder.decode(OrdersFromJSON.self, from: data)
                    
                    
                    var converted: [OrderJSON] = []
                    for pedido in decodedResponse {
                        var b: [ItemInfo] = []
                        for item in pedido.itens {
                            b.append(ItemInfo(nome: item.nome, quantidade: item.quantidade, preco: Double(item.preco), observacoes: item.observacoes, nomeImagem: item.nomeImagem ?? ""))
                        }
                        let a = OrderJSON(name: pedido.nome, items: b, totalValue: Double(pedido.total))
                        converted.append(a)
                    }
                    if converted.isEmpty {
                    }
                    self.openOrders = converted
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
    
    // MARK: Tá funcionando
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
					self.menu = CardapioTransform(json: decodedResponse).entity
                    
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
    
    // MARK: N é chamada, mas funciona
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
    
    // MARK: Em processameto
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
                    let decodedResponse = try self.decoder.decode(FinishedOrderFromJSON.self, from: data)
                    var datess: [String: [OrderJSON]] = [:]
                    for order in decodedResponse {
                        var itens: [ItemInfo] = []
                        for item in order.itens {
                            itens.append(ItemInfo(nome: item.nome, quantidade: item.quantidade, preco: Double(item.valor), observacoes: "", nomeImagem: item.nomeImagem))
                        }
                        let oJ = OrderJSON(name: order.nome, items: itens, totalValue: Double(order.total))
                        datess[order.data] = []
                        datess[order.data]?.append(oJ)
                    }
                    var sendableData: [FinishedDatesJSON] = []
                    for (key, value) in datess {
                        sendableData.append(FinishedDatesJSON(dateTitle: key, finishedOrders: value))
                    }
                    
                    self.finishedOrders = sendableData
                    
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
    
    // MARK: getEndOrder
    // Em teoria, não retorna nada
    /// Faz chamada GET para Finaliza/{nome}
    
    // MARK: Em processameto
    func getEndOrder(for name: String, completion: @escaping () -> Void) {
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
    
    // MARK: Tá funcionando
    func getRemoveItemOpenOrder(for name: String, item: ItemInfo, completion: @escaping () -> Void) {
        guard let request = createRequest(endpoint: "RemoveDaComanda/\(name)/\(item.nome)") else {
            //print("RemoveDaComanda/\(name)/\(item.nome)")
            print("Erro ao criar request")
            return
        }
        session.dataTask(with: request) { data, respose, error in
            
            if let erro = error {
                print("Erro: \(erro.localizedDescription)")
                return
            }
//            DispatchQueue.main.async {
//                guard let data = data else { return }
//                do {
//                    let decodedResponse = try self.decoder.decode(OrderJSON2Element.self, from: data)
//                    print(data)
//
//
//                    var b: [Itemn] = []
//                    for item in decodedResponse.itens {
//                        b.append(Itemn(nome: item.nome, quantidade: item.quantidade, preco: Double(item.preco), observacoes: item.observacoes))
//                    }
//                    let conv = OrderJSON(name: decodedResponse.nome, items: b, totalValue: Double(decodedResponse.total))
//
//                    for pedido in self.openOrders {
//                        if pedido.name == conv.name{
//                            pedido.items = conv.items
//                        }
//                    }
                    
                    
                    // Linha de testes, por favor não apagar
                    //print(decodedResponse)
//                    var converted: [OrderJSON] = []
//                    for pedido in decodedResponse {
//                        var b: [Itemn] = []
//                        for item in pedido.itens {
//                            b.append(Itemn(nome: item.nome, quantidade: item.quantidade, preco: Double(item.preco), observacoes: item.observacoes))
//                        }
//                        let a = OrderJSON(name: pedido.nome, items: b, totalValue: Double(pedido.total))
//                        converted.append(a)
                    
//                    DispatchQueue.main.async {
                        completion()
//                    }
//                }
//                catch {
//                    print("Erro: \(error.localizedDescription)")
//                }
//            }
            
        }.resume()
    }
    
    // MARK: getRemoveItemMenu
    // Em teoria, não retorna nada
    /// Faz chamada GET para RemoveDoCardapio/{item}
    
    // MARK: Nunca é chamada
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
    
    // MARK: Nunca é chamada
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
    
    // MARK: Tá funcionando
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
                "Nome": $0.nome,
                "Quantidade": $0.quantidade,
                "Preco": $0.preco,
                "Observacoes": $0.observacoes == "Observações" || $0.observacoes == "" || $0.observacoes == " " ? "Nenhuma Observação" : $0.observacoes,
                "Nome Imagem": $0.nomeImagem
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
    
    // MARK: Não existe onde chamar
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
    
    // MARK: Não foi criada
//    func postAddItemToMenu(for name: ItemJSON) {
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
//    }
    
    
    
    
}
