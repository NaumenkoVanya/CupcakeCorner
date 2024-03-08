//
//  ValidatingAndDisablingForms.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import SwiftUI

struct ValidatingAndDisablingForms: View {
    @State private var userName = ""
    @State private var email = ""
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form{
            Section {
                TextField("UserName", text: $userName)
                TextField("Email", text: $email)
            }
            
            Section{
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    ValidatingAndDisablingForms()
}
