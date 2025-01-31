//
//  RegisterView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI


struct RegisterView: View {
    @State private var registerData = RegisterData(name: "", mail: "", password: "")
    @Environment(\.dismiss) private var dismiss
    @State private var canNavigateAfterRegister  = false
    
    private let postURLString = "https://mypizza.lesmoulinsdudev.com/register"
    
    // Endpoint pour l'inscription
    func postRegister() {
        let params: [String: Any] = ["name": "\(registerData.name)", "mail": "\(registerData.mail)", "password": "\(registerData.password)"]
        if let url = URL(string: self.postURLString) {
            APIService.shared.postRequest(url: url, params: params, type: RegisterStatus.self, completionHandler: { (response) in
                if (response.status == "check the response code !"){
                    print("Compte créer avec succès !")
                    print(response)
                    canNavigateAfterRegister = true
                }
            }, errorHandler: { (error: String) in
                print(error)
            })
        }
    }
    
    var body: some View {
        VStack{
            VStack {
                //titre
                Text("Inscription")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                    .foregroundColor(.white)
                    .padding(.top)
                           
                VStack(spacing: 20) {
                    //nom
                    TextField("Nom", text: $registerData.name)
                        .padding()
                        .background(Color(.systemGray6))
                    //mail
                    TextField("Adresse mail", text: $registerData.mail)
                        .padding()
                        .background(Color(.systemGray6))
                        .keyboardType(.emailAddress)
                    //mot de passe
                    SecureField("Mot de passe", text: $registerData.password)
                        .padding()
                        .background(Color(.systemGray6))
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                
                // bouton pour créer un compte
                Button(action: {
                    postRegister()
                }) {
                    Text("Enregistrer")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(red: 0.6, green: 0, blue: 0))
                        .font(.headline)
                        .cornerRadius(30)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
                .navigationDestination(isPresented: $canNavigateAfterRegister) {
                    LoginView()
                }
                
                Text("Déjà un compte ?")
                    .font(.headline)
                    .foregroundColor(Color.white)
                
                // Bouton pour retourner à la page de connexion
                Button("Retour à la page de connexion") {
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color(red: 0.6, green: 0, blue: 0))
                .font(.headline)
                .cornerRadius(30)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
                
            }
            .background(Rectangle().foregroundColor(Color.black).opacity(0.6))
        }
        .padding()
        .background(Image("pizza"))
    }
}

#Preview {
    RegisterView()
}
