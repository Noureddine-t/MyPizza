//
//  OrderView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI

func getToken() -> String? {
    if let token = UserDefaults.standard.string(forKey: "token") {
        return token
    } else {
        return ""
    }
}
struct OrderView: View {
    
    @Environment(\.dismiss) private var dismiss
    private let token:String? = getToken()
    
    private let getRecipesURLString = "https://mypizza.lesmoulinsdudev.com/recipes"
    private let getDoughsURLString = "https://mypizza.lesmoulinsdudev.com/doughs"
    private let sendOrderURLString = "https://mypizza.lesmoulinsdudev.com/order"
    
    @State private var recipes : [RecipeData] = []
    @State private var doughs : [DoughData] = []
    @State private var orderData = OrderData(recipeId: 1, doughId: 1)
    @State private var canReturnToOrders = false
    
    // Endpoint pour récupérer les recettes
    func getRecipes() {
        if let url = URL(string: self.getRecipesURLString) {
            APIService.shared.getRequest(url: url, type: [RecipeData].self, token: token!, completionHandler: { (response) in
                if (!response.isEmpty) {
                    recipes = response
                    print ("Les recettes sont recues avec succès !")
                    print(response)
                    
                }
                
            }, errorHandler:{ (error:String) in
                print(error)
            })
        }
    }
    
    // Endpoint pour récupérer les pates
    func getDoughs() {
        if let url = URL(string: self.getDoughsURLString) {
            APIService.shared.getRequest(url: url, type: [DoughData].self, token: token!, completionHandler: { (response) in
                if (!response.isEmpty) {
                    doughs = response
                    print("Les pates sont recues avec succès !")
                    print(response)
                }
                
            }, errorHandler:{ (error:String) in
                print(error)
            })
        }
    }
    
    // Endpoint pour envoyer la commande
    func sendOrder() {
        let params: [String: Any] = ["recipeId": orderData.recipeId, "doughId": orderData.doughId]
        if let url = URL(string: self.sendOrderURLString) {
            APIService.shared.postRequest(url: url, params: params, token: token!, type: RegisterStatus.self, completionHandler: { (response) in
                if (response.status == "check the response code !"){
                    print("Commande envoyée avec succès")
                    print(response)
                }
                
            }, errorHandler: { (error: String) in
                print(error)
            })
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Choisissez votre recette")
                    .bold()
                    .foregroundStyle(.white)
                
                //picker pour lister les recettes
                Picker(selection: $orderData.recipeId, label: Text("Recette")) {
                    ForEach(recipes){ recipe in
                        Text(recipe.name)
                            .tag(recipe.id)
                    }
                }
                .onAppear { getRecipes() }
                                
            }
            .padding(.bottom, 10)
            
            HStack {
                
                Text("Sélectionnez votre pâte")
                    .bold()
                    .foregroundStyle(.white)
                
                //picker pour lister les pates
                Picker(selection: $orderData.doughId, label: Text("Pâte")) {
                    ForEach(doughs){ dough in
                        Text(dough.name)
                            .tag(dough.id)
                    }
                }
                .onAppear { getDoughs() }
            }
            .padding(.bottom, 10)
                        
            // Bouton pour commander
            Button(action: {
                sendOrder()
            }) {
                Text("Commander")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(red: 0.6, green: 0, blue: 0))
                    .font(.headline)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
        
            // bouton de retour à la page précédente
            Button(action: {
                canReturnToOrders = true
            }) {
                Text("Retour")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(red: 0.6, green: 0, blue: 0))
                    .font(.headline)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
            .navigationDestination(isPresented: $canReturnToOrders) {
                OrdersView()
            }
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(red: 0, green: 0.1, blue: 0.2))
    }    
}

#Preview {
    OrderView()
}
