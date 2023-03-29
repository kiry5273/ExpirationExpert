//
//  DataController.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/5.
//

import Foundation
import CoreData
import UIKit


class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "ios_app")
    init(){
        container.loadPersistentStores {desc, error in
            if let error = error{
                print("Failed to load the data\(error.localizedDescription)")
            }
            print(NSPersistentContainer.defaultDirectoryURL())
        }
    }
    
    func save(context: NSManagedObjectContext){
        //let context = container.viewContext
        do{
            try context.save()
            print("Data saved")
            print(NSPersistentContainer.defaultDirectoryURL())
        } catch{
            print("Could not save the data")
        }
    }
    
    func delete(product: Product, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestDelete = NSFetchRequest<Product>(entityName: "Product")
        fetchRequestDelete.fetchLimit = 1;
        fetchRequestDelete.predicate = NSPredicate(format:"name==%@", product.name!)
        do{
            let ProductDelete = try context.fetch(fetchRequestDelete)
            context.delete(ProductDelete[0])
            do{
                try context.save()
                print(ProductDelete[0])
            } catch{
                print("Fail to delete")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    func deleteBox(name: String, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestDelete = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestDelete.fetchLimit = 1;
        fetchRequestDelete.predicate = NSPredicate(format:"name==%@", name)
        do{
            let ProductDelete = try context.fetch(fetchRequestDelete)
            ProductDelete[0].name = "0"
            ProductDelete[0].weight_percent = 0
            do{
                try context.save()
                print(ProductDelete[0])
            } catch{
                print("Fail to delete")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    
    
    func findPbyObj(obj: Box, context: NSManagedObjectContext)->Product{
        let fetchRequestRead = NSFetchRequest<Product>(entityName: "Product")
        fetchRequestRead.fetchLimit = 1;
        fetchRequestRead.predicate = NSPredicate(format:"name==%@", obj.name!)
        //print(obj.name!)
        do{
            let ProductRead = try context.fetch(fetchRequestRead)
            return ProductRead[0]
        }
        catch{
            print("Fail to fetch")
        }
        let product = Product(context: context)
        return product
    }
    
    func findObjbyP(product: Product, context: NSManagedObjectContext)->Box{
        //let context = container.viewContext
        //var box = Box(context: context)
        let fetchRequestRead = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestRead.fetchLimit = 1;
        fetchRequestRead.predicate = NSPredicate(format:"name==%@", product.name!)
        do{
            let ProductRead = try context.fetch(fetchRequestRead)
            return ProductRead[0]
        }
        catch{
            print("Fail to fetch")
        }
        let box = Box(context: context)
        return box
    }
    
    func updateName(product: Product, name: String, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestUpdate = NSFetchRequest<Product>(entityName: "Product")
        fetchRequestUpdate.fetchLimit = 1;
        fetchRequestUpdate.predicate = NSPredicate(format:"name==%@", product.name!)
        do{
            let ProductUpdate = try context.fetch(fetchRequestUpdate)
            ProductUpdate[0].name = name;
            do{
                try context.save()
                print(ProductUpdate[0])
            }
            catch{
                print("Fail to update")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    
    func updateClasses(product: Product, classes: String, image: String, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestUpdate = NSFetchRequest<Product>(entityName: "Product")
        fetchRequestUpdate.fetchLimit = 1;
        fetchRequestUpdate.predicate = NSPredicate(format:"name==%@", product.name!)
        do{
            let ProductUpdate = try context.fetch(fetchRequestUpdate)
            ProductUpdate[0].classes = classes
            ProductUpdate[0].image = image
            do{
                try context.save()
                print(ProductUpdate[0])
            }
            catch{
                print("Fail to update")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    func addProduct(name: String, classes: String, image: String, date: String, context: NSManagedObjectContext){
        let product = Product(context: context)
        product.expire = DateUtil().string2DateFormatter(strDate: date)
        product.name = name
        product.classes = classes
        product.image = image
        product.usage_rate = 0
        save(context: context)
    }
    
    func addtoBox(index: Int, name: String, weight_percent: Float, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestAdd = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestAdd.fetchLimit = 1;
        fetchRequestAdd.predicate = NSPredicate(format:"index==%i", index)
        do{
            let BoxAdd = try context.fetch(fetchRequestAdd)
            BoxAdd[0].name = name;
            BoxAdd[0].weight_percent = weight_percent
            do{
                try context.save()
                print(BoxAdd[0])
            }
            catch{
                print("Fail to update")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    func updateBoxWeight(index: Int, weight_percent: Float, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestAdd = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestAdd.fetchLimit = 1;
        fetchRequestAdd.predicate = NSPredicate(format:"index==%i", index)
        do{
            let BoxAdd = try context.fetch(fetchRequestAdd)
            BoxAdd[0].weight_percent = weight_percent
            do{
                try context.save()
                print(BoxAdd[0])
            }
            catch{
                print("Fail to update")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    func updateBoxName(box: Box, name: String, context: NSManagedObjectContext){
        //let context = container.viewContext
        let fetchRequestAdd = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestAdd.fetchLimit = 1;
        fetchRequestAdd.predicate = NSPredicate(format:"name==%@", box.name!)
        do{
            let BoxAdd = try context.fetch(fetchRequestAdd)
            BoxAdd[0].name = name
            do{
                try context.save()
                print(BoxAdd[0])
            }
            catch{
                print("Fail to update")
            }
        }
        catch{
            print("Fail to fetch")
        }
    }
    
    func findBoxbyIndex(index: Int, context: NSManagedObjectContext)->Box{
        //let context = container.viewContext
        // var box = Box(context: context)
        let fetchRequestRead = NSFetchRequest<Box>(entityName: "Box")
        fetchRequestRead.fetchLimit = 1;
        fetchRequestRead.predicate = NSPredicate(format:"index==%i", index)
        print("i: "+String(index))
        do{
            let ProductRead = try context.fetch(fetchRequestRead)
            return ProductRead[0]
        }
        catch{
            print("Fail to fetch")
        }
        let box = Box(context: context)
        return box
    }
    
    
    func deleteAllBox(context: NSManagedObjectContext) {
        //let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Box")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("fail to delete all")
        }
    }
    
    func deleteAllProduct(context: NSManagedObjectContext) {
        //let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("fail to delete all")
        }
    }
    
    func loadBoxData(context: NSManagedObjectContext){
        //let context = container.viewContext
        let obj = Box(context: context)
        obj.name = "0"
        obj.index = 0
        obj.weight_percent = 0.0
        save(context: context)
        
        let obj1 = Box(context: context)
        obj1.name = "0"
        obj1.index = 1
        obj1.weight_percent = 0.0
        save(context: context)
        
        let obj2 = Box(context: context)
        obj2.name = "0"
        obj2.index = 2
        obj2.weight_percent = 0.0
        save(context: context)
        
        let obj3 = Box(context: context)
        obj3.name = "0"
        obj3.index = 3
        obj3.weight_percent = 0.0
        save(context: context)
    }
    
    func loadProductData(context: NSManagedObjectContext){
        //let context = container.viewContext
        let product = Product(context: context)
        product.expire = DateUtil().string2DateFormatter(strDate: "12/30/2022")
        product.name = "Orange"
        product.classes = "vegetable"
        product.image = "vegetable"
        product.usage_rate = 0
        //addtoBox(index: 0, name: "Banana", weight_percent: 0, context: context)
        save(context: context)
        
        let product1 = Product(context: context)
        product1.expire = DateUtil().string2DateFormatter(strDate: "12/21/2022")
        product1.name = "Lotion"
        product1.classes = "makeup"
        product1.image = "makeup"
        product1.usage_rate = 0
        //addtoBox(index: 1, name: "Lotion", weight_percent: 0, context: context)
        save(context: context)
        
        let product2 = Product(context: context)
        product2.expire = DateUtil().string2DateFormatter(strDate: "12/22/2022")
        product2.name = "Tea"
        product2.classes = "drink"
        product2.image = "drink"
        product2.usage_rate = 0
        //addtoBox(index: 2, name: "Tea", weight_percent: 0, context: context)
        save(context: context)
        
        let product3 = Product(context: context)
        product3.expire = DateUtil().string2DateFormatter(strDate: "12/24/2022")
        product3.name = "Cookie"
        product3.classes = "snack"
        product3.image = "snack"
        product3.usage_rate = 0
        //addtoBox(index: 3, name: "Cookie", weight_percent: 0, context: context)
        save(context: context)
    }
    
}
