//
//  DataStore.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/23/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

public final class DataStore {

    private let environment: Environment
    private(set) var persistentContainer: NSPersistentContainer?
    private var context: NSManagedObjectContext!

    public init(environment: Environment = .production) {
        self.environment = environment
    }

    public func load(_ onCompleted: @escaping () -> Void) {
        createTimeSlowerContainer(for: environment, completion: { [weak self] (container) in
            self?.persistentContainer = container
            self?.context = container.viewContext
            onCompleted()
        })
    }

    public func createActivity(withName name: String, type: ActivityType, completion: @escaping (Activity) -> Void) {
        context.performChanges { [unowned self] in
            let activity = Activity.insert(
                withName: name,
                type: type,
                into: self.context)
            return completion(activity)
        }
    }

    public func fetch<T: Managed>(id: String, completion: @escaping (T?) -> Void) {
        let request = T.sortedFetchRequest
        request.predicate = NSPredicate(format: "resourceId == %@", id)
        do {
            let results = try request.execute().first
            completion(results)
        } catch {
            completion(nil)
        }
    }

    public func delete<T: NSManagedObject>(object: T, completion: @escaping () -> Void) {
        object.managedObjectContext?.performChanges {
            let _ = ManagedObjectObserver(object: object, changeHandler: { (changeType) in
                if changeType == .delete {
                    completion()
                }
            })

            object.managedObjectContext?.delete(object)
        }
    }

}
