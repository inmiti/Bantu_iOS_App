//
//  LoginView.swift
//  Bantu_iOS
//
//  Created by Silvia Casanova Martinez on 30/3/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Binding var state: ViewState
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(decorative:"")
                    .resizable()
                    .background(Color("backgroundBantu"))
                    .edgesIgnoringSafeArea(.all)
                //Background
                VStack(spacing: 11) {
                    Image("Icon2")
                        .resizable()
                        .frame(width: 150, height: 150)
                    //Title
                    Text("Wellcome Back")
                        .font(.system(size: 28))
                        .bold()
                        .id(2)
                    Text("Login to your Account")
                        .font(.system(size: 15))
                        .id(3)
                    VStack(alignment: .leading, spacing: 20){
                        CustomTextFieldView(textComponent: loginViewModel.email,
                                            isPassword: false,
                                            isError: false, titletextField: "Your email")
                        CustomTextFieldView(textComponent: loginViewModel.password,
                                            isPassword: true,
                                            isError: false, titletextField: "Your Password")
                    }
                    HStack(spacing: 110){
                        HStack(spacing: 4) {
                            //Remember user
                            CheckBoxButton(isSelected: $loginViewModel.rememberMe)
                            Text("Remember me")
                                .foregroundColor(.black)
                                .font(.system(size: 11))
                                .id(9)
                        }
                        Text("Forgot Password?")
                            .foregroundColor(.bantu_orange)
                            .font(.system(size: 11))
                            .id(10)
                    }
                    //Login
                    VStack(spacing: 24) {
                        MainButton(textButton: "Sign in") {
                            state = .home
                        }
                        .padding(.horizontal, 35)
                        
                        //Registration
                        Button {
                            print("Create")
                        } label: {
                            Text("Create an account")
                                .font(.system(size: 14))
                        }
                        .buttonStyle(.bordered)
                        .frame(width: 150, height: 30)
                        .foregroundColor(.black)
                        .background(Color.bantu_orange)
                        .cornerRadius(30)
                        .id(12)
                    }
                }
                .padding(35)
                .lineSpacing(10.0)
                
            }
            .navigationBarHidden(true)
          
        }
    }
}

#Preview {
    LoginView(state: .constant(.login))
    
}


