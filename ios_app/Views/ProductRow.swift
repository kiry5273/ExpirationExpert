//
//  SwiftUIView.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/14.
//

import SwiftUI

struct ProductRow: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.dismiss) var dismiss
    @ObservedObject var product: Product
    var body: some View {
        HStack(spacing: 3) {
            if product.image != nil{
                Image(product.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipped()
                    .padding()
            }
            
            if product.name != nil{
                Text(product.name!)
                    .font(.title2)
                    .frame(width: 150, height: 75, alignment: .leading)
                    .lineSpacing(18)
            }
            if product.expire != nil{
                Text("\(DateUtil().dateDiff(start: Date(), end: product.expire!))"+" 天")
                    .font(.title2)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 70, height: 75, alignment: .trailing)
                    .lineSpacing(18)
            }
//            if DateUtil().dateDiff(start: Date(), end: product.expire!)<0{
//                Text("\(DateUtil().dateDiff(start: Date(), end: product.expire!))"+" 天")
//                    .font(.title2)
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.trailing)
//                    .frame(width: 70, height: 75, alignment: .trailing)
//                    .lineSpacing(18)
//            }
//            else{
//                Text("\(DateUtil().dateDiff(start: Date(), end: product.expire!))"+" 天")
//                    .font(.title2)
//                    .multilineTextAlignment(.trailing)
//                    .frame(width: 70, height: 75, alignment: .trailing)
//                    .lineSpacing(18)
//            }
        }
        .swipeActions{
            Button{
                //DataController().deleteBox(name: product.name!, context: managedObjectContext)
                DataController().delete(product: product, context: managedObjectContext)
            }label: {
                Label("", systemImage: "trash")
            }
            .tint(.red)
        }
    }

}

//struct ProductRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductRow()
//    }
//}
