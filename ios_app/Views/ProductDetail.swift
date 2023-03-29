//
//  ProductDetail.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/14.
//

import SwiftUI

struct ProductDetail: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @State private var name = ""
    @State private var classesindex = 0
    @State private var imageindex = 0
    @State private var showalert = false
    @State private var showalert2 = false
    let role = ["vegetable", "makeup", "drink", "snack"]
    let img_v = ["vegetable", "icon_vegetable_broccoli", "icon_vegetable_cabbage", "icon_vegetable_lemon", "icon_vegetable_strawberry"]
    let img_m = ["makeup", "icon_makeup_eye_shadows", "icon_makeup_foundation", "icon_makeup_mascara"]
    let img_d = ["drink", "icon_drink_cocktail", "icon_drink_milk", "icon_drink_smoothie", "icon_drink_soda_can", "icon_drink_soft_drink", "icon_drink_whisky"]
    let img_s = ["snack", "icon_snack_bakery", "icon_snack_cake", "icon_snack_canne_food", "icon_snack_chips", "icon_snack_cookie", "icon_snack_cookies", "icon_snack_jam", "icon_snack_snack"]
    @ObservedObject var product: Product
    var body: some View {
        VStack{
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color(red: 0, green: 0, blue: 0, opacity: 0))
                    .frame(width: 19, height: 54)

                HStack(spacing: 100) {
                    Image(uiImage: #imageLiteral(resourceName: "cancel"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()

                        Text("編輯")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 32)
                        .lineSpacing(35)
                    
                    Button(action:{
                        DataController().updateName(product: product, name: name, context: managedObjectContext)
                        if product.classes == "vegetable"{
                            DataController().updateClasses(product: product, classes: role[classesindex], image: img_v[imageindex], context: managedObjectContext)
                        }
                        else if product.classes == "makeup"{
                            DataController().updateClasses(product: product, classes: role[classesindex], image: img_m[imageindex], context: managedObjectContext)
                        }
                        else if product.classes == "drink"{
                            DataController().updateClasses(product: product, classes: role[classesindex], image: img_d[imageindex], context: managedObjectContext)
                        }
                        else if product.classes == "snack"{
                            DataController().updateClasses(product: product, classes: role[classesindex], image: img_s[imageindex], context: managedObjectContext)
                        } 
                    }){
                        Image(uiImage: #imageLiteral(resourceName: "done"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 36, height: 36)
                            .clipped()
                    }
                    
                }
                .frame(width: 337, height: 36)

                Rectangle()
                    .fill(Color(red: 0, green: 0, blue: 0, opacity: 0))
                    .frame(width: 19, height: 54)
            }
            .frame(width: 375, height: 54)
            .background(Color.white)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.30), radius: 0, y: 0.50)
            .frame(width: 375, height: 54)
            List{
                //名稱
                HStack(spacing: 7) {
                    Image(uiImage: #imageLiteral(resourceName: "name"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                                    
                    Text("名稱")
                        .font(.title3)
                        .frame(width: 65, height: 75)
                        .lineSpacing(18)
                    
                    Text(product.name!)
                        .font(.title3)
                        .frame(width: 139, height: 75)
                        .lineSpacing(18)
                   
                    Button(action: {
                        showalert.toggle()
                    }){
                        Image(uiImage: #imageLiteral(resourceName: "rename"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 36, height: 36)
                            .clipped()
                            .frame(width: 36, height: 36)
                    }
                    .alert("Edit", isPresented: $showalert, actions:{
                        TextField("Enter new name", text: $name)
                        Button("OK", action: {
//                            DataController().updateBoxName(box: DataController().findObjbyP(product: product, context: managedObjectContext), name: name, context: managedObjectContext)
                            DataController().updateName(product: product, name: name, context: managedObjectContext)
                        })
                    })
                    
                }
                .frame(width: 320, height: 75)
                
                //過期日
                HStack(spacing: 7) {
                    Image(uiImage: #imageLiteral(resourceName: "expiration_day"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                    
                    
                    Text("過期日")
                        .font(.title3)
                        .frame(width: 65, height: 75)
                        .lineSpacing(18)
                    
                    Text(DateUtil().date2StringFormatter(date: product.expire!))
                        .font(.title3)
                        .frame(width: 139, height: 75)
                        .lineSpacing(18)
                    
                    Rectangle()
                        .fill(Color(red: 0, green: 0, blue: 0, opacity: 0))
                        .frame(width: 28, height: 28)
                }
                .frame(width: 320, height: 75)
                
                //分類
                HStack(spacing: 7) {
                    Image(uiImage: #imageLiteral(resourceName: "tag"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                    
                    
                    Text("分類")
                        .font(.title3)
                        .frame(width: 50, height: 75)
                        .lineSpacing(18)
                        
                    
                    Text(product.classes!)
                        .font(.title3)
                        .frame(width: 90, height: 75)
                        .lineSpacing(18)
                        .padding()
                    
                    Picker("select", selection: $classesindex){
                        Text(role[0]).tag(0)
                        Text(role[1]).tag(1)
                        Text(role[2]).tag(2)
                        Text(role[3]).tag(3)
                    }
                    .labelsHidden()
                    .padding()
                    .frame(width: 60, height: 75)
                        
                }
                .frame(width: 320, height: 75)
                
                //圖片
                HStack(spacing: 7) {
                    Image("edit_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()


                    Text("圖片")
                        .font(.title3)
                        .frame(width: 50, height: 75)
                        .lineSpacing(18)
                        //.padding()

                    Image(product.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .padding(40)
                        

                    Picker("img_name", selection: $imageindex){
                        if product.classes == "vegetable"{
                            ForEach(0 ..< img_v.count, id: \.self) { i in
                                Image(self.img_v[i]).tag(i)
                            }
                        }
                        else if product.classes == "makeup"{
                            ForEach(0 ..< img_m.count, id: \.self) { i in
                                Image(self.img_m[i]).tag(i)
                            }
                        }
                        else if product.classes == "drink"{
                            ForEach(0 ..< img_d.count, id: \.self) { i in
                                Image(self.img_d[i]).tag(i)
                            }
                        }
                        else if product.classes == "snack"{
                            ForEach(0 ..< img_s.count, id: \.self) { i in
                                Image(self.img_s[i]).tag(i)
                            }
                        }
                    }
                    .labelsHidden()
                    .padding(30)
                    .frame(width: 20, height: 20)
    
                }
                .frame(width: 320, height: 75)
                
                //提醒
                HStack(spacing: 7) {
                    Image(uiImage: #imageLiteral(resourceName: "notification"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                    
                    
                    Text("提醒")
                        .font(.title3)
                        .frame(width: 65, height: 75)
                        .lineSpacing(18)
                    
                    Text("分類預設")
                        .font(.title3)
                        .frame(width: 139, height: 75)
                        .lineSpacing(18)
                    
                    Image(uiImage: #imageLiteral(resourceName: "edit_button"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                }
                .frame(width: 320, height: 75)
                
                //備註
                HStack(spacing: 7) {
                    Image(uiImage: #imageLiteral(resourceName: "note"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                    
                    
                    Text("備註")
                        .font(.title3)
                    
                        .frame(width: 65, height: 75)
                        .lineSpacing(18)
                    
                    Text("None")
                        .font(.title3)
                        .frame(width: 139, height: 75)
                        .lineSpacing(18)
                    
                    Image(uiImage: #imageLiteral(resourceName: "rename"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .clipped()
                }
                .frame(width: 320, height: 75)
            }
        }
    }
}

//struct ProductDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetail(product)
//    }
//}
