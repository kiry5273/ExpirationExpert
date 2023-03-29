//
//  SwiftUIView.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/14.
//

import SwiftUI

struct Bottom: View {
    var body: some View {
        List{
            HStack(spacing: 5) {
                Image(uiImage: #imageLiteral(resourceName: "all"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)

                Text("全部")
                .fontWeight(.medium)
                .font(.title2)
                .lineSpacing(23.10)
            }
            HStack(spacing: 5) {
                Image(uiImage: #imageLiteral(resourceName: "vegetable"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)

                Text("生鮮食材")
                .fontWeight(.medium)
                .font(.title2)
                .lineSpacing(23.10)
            }
            
        }
    }
}

struct Bottom_Previews: PreviewProvider {
    static var previews: some View {
        Bottom()
    }
}
