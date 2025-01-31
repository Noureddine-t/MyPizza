//
//  LoginView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI


struct LoginView: View {
    @State private var loginData = LoginData(mail: "", password: "")
    @State private var canNavigateToRegister = false
    @State private var canLoginToTheApp  = false
    private let postURLString = "https://mypizza.lesmoulinsdudev.com/auth"
    
    // Endpoint pour la connexion
    func postLogin() {
        let params: [String: Any] = ["mail": "\(loginData.mail)", "password": "\(loginData.password)"]
        if let url = URL(string: self.postURLString) {
            APIService.shared.postRequest(url: url, params: params, type: TokenData.self, completionHandler: { (response) in
                let token = response.token
                if (token != ""){
                    print("Connexion réussie !")
                    print(response)
                    canLoginToTheApp  = true
                    UserDefaults.standard.setValue(token, forKey: "token")
                }
                
            }, errorHandler: { (error: String) in
                print(error)
            })
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    //titre
                    Text("My Pizza !")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        //mail
                        TextField("Adresse mail", text: $loginData.mail)
                            .padding()
                            .background(Color(.systemGray6))
                            .keyboardType(.emailAddress)
                        //mot de passe
                        SecureField("Mot de passe", text: $loginData.password)
                            .padding()
                            .background(Color(.systemGray6))
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    
                    // Bouton de connexion
                    Button(action: {
                        postLogin()
                    } ){
                        Text("Connexion")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(red: 0.6, green: 0, blue: 0))
                            .font(.headline)
                            .cornerRadius(30)
                    }
                    
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                    .navigationDestination(isPresented: $canLoginToTheApp) {
                        OrdersView()
                    }
                    
                    
                    Text("Pas encore de compte ?")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    // bouton pour créer un compte
                    Button("Créer un compte"){
                        canNavigateToRegister = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(red: 0.6, green: 0, blue: 0))
                    .font(.headline)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                    .navigationDestination(isPresented: $canNavigateToRegister) {
                        RegisterView()
                    }
                }
                .background(Rectangle().foregroundColor(Color.black).opacity(0.6))
                
            }
            .padding()
            .background(Image("pizza"))
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
