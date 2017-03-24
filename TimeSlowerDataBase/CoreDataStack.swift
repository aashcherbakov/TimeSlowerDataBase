//
//  CoreDataStack.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/22/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

public enum Environment {
    case production
    case test
}

func createTimeSlowerContainer(for environment: Environment, completion: @escaping (NSPersistentContainer) -> ()) {
    var container: NSPersistentContainer
    switch environment {
    case .production:
        container = NSPersistentContainer(name: "TimeSlower")
    case .test:
        container = NSPersistentContainer(name: "TimeSlower", managedObjectModel: managedObjectModel())
        container.persistentStoreDescriptions = [inMemoryStoreDescription()]
    }

    container.loadPersistentStores { (_, error) in
        guard error == nil else {
            fatalError("Failed to load store: \(error)")
        }

        DispatchQueue.main.async {
            completion(container)
        }
    }
}

fileprivate func inMemoryStoreDescription() -> NSPersistentStoreDescription {
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.configuration = "Default"
    return description
}

fileprivate func managedObjectModel() -> NSManagedObjectModel {
    let bundles = [Bundle(for: Activity.self)]
    guard let model = NSManagedObjectModel.mergedModel(from: bundles) else {
        fatalError("model not found")
    }

    return model
}
