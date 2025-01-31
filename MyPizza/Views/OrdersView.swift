//
//  OrdersView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI

struct OrdersView: View {
    @State private var canNavigateToOrder  = false
    
    private let token:String? = getToken()
    private let getOrdersURLString = "https://mypizza.lesmoulinsdudev.com/orders"
    @State private var orders : [OrdersData] = []
    
    // Endpoint pour récupérer la liste des commandes
    func getOrders() {
        if let url = URL(string: self.getOrdersURLString) {
            APIService.shared.getRequest(url: url, type: [OrdersData].self, token: token!, completionHandler: { (response) in
                if (!response.isEmpty) {
                    orders = response
                    print ("La liste des commandes recue avec succès !")
                    print(response)
                }
                
            }, errorHandler:{ (error:String) in
                print(error)
            })
        }
    }
    
    var body: some View {
        
        VStack {
            Text("Vos dernières commandes")
                .bold()
                .foregroundStyle(.white)
            
            List(orders.indices, id:\.self) { index in
                OrdersCellView(orders: orders[index])
            }.onAppear {
                getOrders()
                print("Orders après récupération : \(orders)")
            }
            
            // bouton pour commander
            Button("Nouvelle commande") {
                canNavigateToOrder = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color(red: 0.6, green: 0, blue: 0))
            .font(.headline)
            .cornerRadius(30)
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
            .navigationDestination(isPresented: $canNavigateToOrder) {
                OrderView()
            }
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(red: 0, green: 0.1, blue: 0.2))
    }
}

#Preview {
    OrdersView()
}
