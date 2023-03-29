//
//  AddProduct.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/5.
//

import SwiftUI

struct AddProduct: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.dismiss) var dismiss
    @State private var name = ""
    @State private var date = ""
    @State private var classesindex = 0
    @State private var usage_rate = 0.0
    @State private var expire = "2022/01/01 2:31:00 PM"
    let role = ["vegetable", "makeup", "drink", "snack"]
    var body: some View {
        Form{
            TextField("Prodcut name", text: $name)
            TextField("Date", text: $date)
            VStack{
                Picker(selection: $classesindex){
                    Text(role[0]).tag(0)
                    Text(role[1]).tag(1)
                    Text(role[2]).tag(2)
                    Text(role[3]).tag(3)
                } label: {
                    Text("Select")
                }
            }
//            VStack{
//                Text("UsageRate: \(usage_rate)")
//                Slider(value: $usage_rate, in: 0...100, step: 10)
//            }
//            .padding()
            HStack{
                Spacer()
                Button("Submit"){
                    DataController().addProduct(name: name, classes: role[classesindex], image: role[classesindex], date: date, context: managedObjectContext)
                    dismiss()
                }
                Spacer()
            }
            Button("Reset"){
                DataController().deleteAllProduct(context: managedObjectContext)
                DataController().deleteAllBox(context: managedObjectContext)
                DataController().loadBoxData(context: managedObjectContext)
            }
            Button("load product"){
                DataController().loadProductData(context: managedObjectContext)
            }
        }
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProduct()
    }
}
