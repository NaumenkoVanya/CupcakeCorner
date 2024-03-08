//
//  AddingCodableConformanceToAnObservableClass.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import SwiftUI

struct AddingCodableConformanceToAnObservableClass: View {
    @Observable
    class User: Codable {
        enum CodingKeys: String, CodingKey {
                case _name = "name"
            }
        var name = "Taylor"
    }
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    AddingCodableConformanceToAnObservableClass()
}
