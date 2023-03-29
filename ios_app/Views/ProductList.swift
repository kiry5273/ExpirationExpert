//
//  ProductList.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/14.
//

import SwiftUI
import CoreData

struct SearchBar: View{
    @Binding var text: String
    @State private var isEditing = false
    var body: some View{
        HStack {
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct ProductList: View {
    @State private var searchText = ""
    @State private var showingBottomSheet = false
    @State var count: Int = 0;
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expire)]) var product: FetchedResults<Product>
    var body: some View {
            NavigationView{
                VStack{
                    HStack(spacing: 82) {
                        Button(action: {
                            showingBottomSheet.toggle()
                        }){
                            HStack(spacing: 0) {
                                Image(uiImage: #imageLiteral(resourceName: "all"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 36, height: 36)
                                
                                Text("全部")
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 65, height: 32)
                                    .lineSpacing(35)
                                
                                Image(uiImage: #imageLiteral(resourceName: "arrow"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                            }

                        }
                        .sheet(isPresented: $showingBottomSheet){
                            Bottom().presentationDetents([.fraction(0.3), .medium])
                        }
                        
                        Button(action: {
                            for product in product{
                                if DateUtil().dateDiff(start: Date(), end: product.expire!)<0 {
                                    DataController().delete(product: product, context: managedObjectContext)
                                }
                            }
                        }){
                            Image(uiImage: #imageLiteral(resourceName: "delete"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                        }
                        }
                        .padding(.vertical, 11)
                        .padding(.leading, 129)
                        .padding(.trailing, 19)
                    
                SearchBar(text: $searchText)
                    .padding(.top, -10)
                List{
                    ForEach(product){ product in
                        if product.name != nil{
                            NavigationLink(destination: ProductDetail(product: product)){
                                ProductRow(product: product)
                            }
                        }
                    }
                }
                Button(action: {
                    if count == 0{
                        DataController().addProduct(name: "Coke", classes: "drink", image: "drink", date: "08/05/2023", context: managedObjectContext)
                        self.count+=1
                    }
                    else if count==1{
                        DataController().addProduct(name: "Banana", classes: "vegetable", image: "vegetable", date: "12/30/2022", context: managedObjectContext)
                        self.count+=1
                    }
                    else if count==2{
                        DataController().addProduct(name: "Bread", classes: "snack", image: "snack", date: "12/29/2022", context: managedObjectContext)
                        self.count+=1
                    }
                    
                }){
                    Text(".")
                }
            }
        }
    }
}



struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
