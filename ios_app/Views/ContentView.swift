//
//  ContentView.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/5.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView{
            ProductList()
                .tabItem{
                    Image(uiImage:  #imageLiteral(resourceName: "home"))
                }
            Text("calendar")
                .tabItem{
                    Image(uiImage:  #imageLiteral(resourceName: "calendar"))
                }
            BoxView()
                .tabItem{
                    Image(uiImage:  #imageLiteral(resourceName: "box"))
                }
            AddProduct()
                .tabItem{
                    Image(uiImage:  #imageLiteral(resourceName: "setting"))
                }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
