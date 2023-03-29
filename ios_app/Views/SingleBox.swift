//
//  SingleBox.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/15.
//

import SwiftUI

struct SingleBox: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    var timer: Timer?
    @ObservedObject var obj: Box
    var body: some View {
        Rectangle()
            .fill(Color(red: 0, green: 0, blue: 0, opacity: 0))
            .border(Color.black, width: 2)
            .frame(width: 165, height: 130)
            .onAppear(){
                callFunc()
            }
            .overlay(){
                if obj.weight_percent>=85{
                    Image("box_quantity")
                    .resizable()
                    .frame(width: 160, height: 125)
                }
                else if obj.weight_percent<85 && obj.weight_percent>=65{
                    Image("box_quantity_75")
                    .resizable()
                    .frame(width: 160, height: 125)
                }
                else if obj.weight_percent<65 && obj.weight_percent>=35{
                    Image("box_quantity_50")
                    .resizable()
                    .frame(width: 160, height: 125)
                }
                else if obj.weight_percent<35 && obj.weight_percent>0{
                    Image("box_quantity_25")
                    .resizable()
                    .frame(width: 160, height: 125)
                }
                
                }.overlay(){
                    VStack{
                        if obj.name == "0"{
                            Image("box_empty")
                            .resizable()
                            .frame(width: 64, height: 64)
                            Divider()
                        }
                        else{
                            Image(DataController().findPbyObj(obj: obj, context: managedObjectContext).image!)
                                .resizable()
                                .frame(width: 64, height: 64)
                            Divider()
                            HStack{
                                Text(obj.name!)
                                Text("\(obj.weight_percent, specifier: "%.1f")%")
                            }
                        }
                    }
                }
    }
    func callFunc() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("-----> Requesting...")
            let url = URL(string: "https://api.thingspeak.com/channels/1977497/feeds/last.json?api_key=33KTK09YXY0QQ3NP")!
            let url2 = URL(string: "https://api.thingspeak.com/channels/1993493/feeds/last.json?api_key=MGPFJIL1CTEXLN1P")!
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let (data2, _) = try await URLSession.shared.data(from: url2)
                    let decoder = JSONDecoder()
                    let decoder2 = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(JsonData.self, from: data)
                        let decodedData2 = try decoder2.decode(JsonData.self, from: data2)
//                        print(decodedData.field1)
//                        print(decodedData.field2)
//                        print(decodedData.field3)
//                        print(decodedData2.field1)
//                        print(decodedData2.field2)
//                        print(decodedData2.field3)
//                        if Float(decodedData.field1)! <= 100.0{
//                            DataController().addtoBox(index: 0, name: "Cofee", weight_percent: Float(decodedData.field1)!, context: managedObjectContext)
//                        }
                        
                        //field1
                        if decodedData2.field1 == "1"{
                            DataController().addtoBox(index: 0, name: "Coke", weight_percent: Float(decodedData.field1)!, context: managedObjectContext)
                        }
                        else if decodedData2.field1 == "2"{
                            DataController().addtoBox(index: 0, name: "Banana", weight_percent: Float(decodedData.field1)!, context: managedObjectContext)
                        }
                        else if decodedData2.field1 == "3"{
                            DataController().addtoBox(index: 0, name: "Bread", weight_percent: Float(decodedData.field1)!, context: managedObjectContext)
                        }
                        else if decodedData2.field1 == "0"{
                            DataController().addtoBox(index: 0, name: "0", weight_percent: 0, context: managedObjectContext)
                        }
                        //field2
                        if decodedData2.field2 == "1"{
                            DataController().addtoBox(index: 1, name: "Coke", weight_percent: Float(decodedData.field2)!, context: managedObjectContext)
                        }
                        else if decodedData2.field2 == "2"{
                            DataController().addtoBox(index: 1, name: "Banana", weight_percent: Float(decodedData.field2)!, context: managedObjectContext)
                        }
                        else if decodedData2.field2 == "3"{
                            DataController().addtoBox(index: 1, name: "Bread", weight_percent: Float(decodedData.field2)!, context: managedObjectContext)
                        }
                        else if decodedData2.field2 == "0"{
                            DataController().addtoBox(index: 1, name: "0", weight_percent: 0, context: managedObjectContext)
                        }
                        //field3
                        if decodedData2.field3 == "1"{
                            DataController().addtoBox(index: 2, name: "Coke", weight_percent: Float(decodedData.field3)!, context: managedObjectContext)
                        }
                        else if decodedData2.field3 == "2"{
                            DataController().addtoBox(index: 2, name: "Banana", weight_percent: Float(decodedData.field3)!, context: managedObjectContext)
                        }
                        else if decodedData2.field3 == "3"{
                            DataController().addtoBox(index: 2, name: "Bread", weight_percent: Float(decodedData.field3)!, context: managedObjectContext)
                        }
                        else if decodedData2.field3 == "0"{
                            DataController().addtoBox(index: 2, name: "0", weight_percent: 0, context: managedObjectContext)
                        }
                    }
                    catch
                    {
                        print("error: \(error)")
                    }
                } catch {
                    print(error)
                }
            }
            print("-----> Done")
            callFunc()
        }
    }
}

//struct SingleBox_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleBox().previewLayout(.fixed(width: 165, height: 130))
//    }
//}
