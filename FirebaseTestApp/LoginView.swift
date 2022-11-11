//
//  LoginView.swift
//  FirebaseTestApp
//
//  Created by Ashfaq on 12/11/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase



struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showRegistrationView = false
    @EnvironmentObject var viewlogin : AppViewModel
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue
                RoundedRectangle(cornerRadius: 1, style: .continuous)
                    .foregroundStyle(.cyan)
                    .frame(width: 1000,height: 450)
                    .rotationEffect(.degrees(135))
                    .offset(y: 350)
                VStack (spacing: 25){
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    
                    
                    
                    Button(action: {
                        if(!email.isEmpty && !password.isEmpty)
                        {
                            viewlogin.signIn(email: email, password: password)
                            
                        }
                        
                        
                    }, label: {
                        Text("Login")
                        
                    })
                    .foregroundColor(.black)
                    .frame(width:200 ,height: 50)
                    .background(Color.yellow.opacity(1))
                    .cornerRadius(10)
                    
                    //.navigate(to: Registration(), when: $showRegistrationView)
                    //NavigationLink("", destination: Registration, isActive: $showRegistrationView)
                    NavigationLink(destination: ContentView(), label: {
                        Text("New Here?")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red.opacity(1))
                            .cornerRadius(10)
                    })
                    
                }
                
            }
            .ignoresSafeArea()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            VStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
        
    }
}
