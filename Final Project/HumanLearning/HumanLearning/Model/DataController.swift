////
////  DataController.swift
////  HumanLearning
////
////  Created by Morrison on 4/30/18.
////  Copyright © 2018 Matthew Morrison. All rights reserved.
////
//
//import UIKit
//import CoreData
//class DataController: NSObject {
//    var managedObjectContext: NSManagedObjectContext
//    init(completionClosure: @escaping () -> ()) {
//        let PersistentContainer = NSPersistentContainer(name: "DataModel")
//        PersistentContainer.loadPersistentStores() { (description, error) in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//            completionClosure()
//        }
//    }
//}
