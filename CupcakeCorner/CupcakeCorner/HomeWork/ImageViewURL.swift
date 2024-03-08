//
//  ImageViewURL.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import SwiftUI

struct ImageViewURL: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Не могу загрузить картинку")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200,height: 200)
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in image
//            .resizable()
//            .scaledToFit()
//        } placeholder: {
//            Color.red
//        }
//        .frame(width: 200, height: 200)
    }
}

#Preview {
    ImageViewURL()
}
