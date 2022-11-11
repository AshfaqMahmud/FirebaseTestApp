//
//  ContentView.swift
//  FirebaseTestApp
//
//  Created by Ashfaq on 12/11/22.
//


import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseDatabase

class AppViewModel: ObservableObject {
    
    
    let auth = Auth.auth()              //Firebase Authentication
    @Published var signedIn = false
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            //success
            DispatchQueue.main.async {
                self.signedIn = true
            }
        }
    }
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                
                return
            }
            DispatchQueue.main.async {
                self.signedIn = true
            }
            
        }
    }
}

class WriteViewModel: ObservableObject{
    private let ref = Database.database().reference()
    func signUp(username: String, fullname: String, email: String, age: String, password: String, phone: String, gender: String)
    {
        ref.child("users").child(username).child("Fullname").setValue(fullname)
        ref.child("users").child(username).child("Email").setValue(email)
        ref.child("users").child(username).child("Password").setValue(password)
        ref.child("users").child(username).child("Age").setValue(age)
        ref.child("users").child(username).child("Gender").setValue(gender)
        ref.child("users").child(username).child("Phone").setValue(phone)
    }
}

struct ContentView: View {
    
    //insert variables
    @State private var username=""
    @State private var password=""
    @State private var cpassword=""
    @State private var email=""
    @State private var fullname=""
    @State private var age=""
    @State private var selectedgender="Male"
    @State private var phone=""
    
    @State private var showAlert = false
    
    @EnvironmentObject var viewmodel : WriteViewModel
    @EnvironmentObject var viewmodel2 : AppViewModel
    
    //gender picker
    private let gender: [String] = [
        "Male",
        "Female",
        "Other"
    ]
    
    
    
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .foregroundStyle(.blue)
                .frame(width: 1000,height: 450)
                .rotationEffect(.degrees(135))
                .offset(y: 350)
            
            VStack (spacing: 15){
                Text("Registration")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Fullname", text: $fullname) //fullname
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(1))
                    .cornerRadius(10)
                TextField("Email", text: $email) //email
                    .padding()
                    .keyboardType(.emailAddress)
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(1))
                    .cornerRadius(10)
                TextField("Username (desired)", text: $username) //username
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(1))
                    .cornerRadius(10)
                
                Picker("Select Gender", selection: $selectedgender){
                    ForEach(gender, id: \.self) {
                        Text($0)
                    }
                }
                .accentColor(Color.black.opacity(0.5))
                .pickerStyle(.menu)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.white.opacity(1))
                .cornerRadius(10)
                /*Text("You selected: \(selectedgender)")
                 .padding()
                 .keyboardType(.emailAddress)
                 .frame(width: 300, height: 50)
                 .background(Color.white.opacity(1))
                 .cornerRadius(10)*/
                
                Group{
                    TextField("Age", text: $age) //username
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    TextField("Phone", text: $phone) //phone
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password) //password
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    SecureField("Confirm Password", text: $cpassword) //confirm password
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                    
                    
                    Button(action: {
                        if(!username.isEmpty && !fullname.isEmpty && !email.isEmpty && !password.isEmpty && !cpassword.isEmpty && !age.isEmpty && !phone.isEmpty)
                        {
                            if(password != cpassword)
                            {
                                
                            }
                            else
                            {
                                viewmodel.signUp(username: username, fullname: fullname, email: email, age: age, password: password, phone: phone, gender: selectedgender)
                                viewmodel2.signUp(email: email, password: password)
                            }
                        }
                        
                    }, label: {
                        Text("Registration")
                    })
                    
                    
                    .foregroundColor(.white)
                    .frame(width:150 ,height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    
                }
                
                
            }
        }
        .ignoresSafeArea()
        
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
