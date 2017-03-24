//
//  NSManagedObjectContext+Extensions.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/22/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }

        return object
    }

    public func saveOrRollBack() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }


    /// Best practice to have `perform` block to interact with context.
    ///
    /// - Parameter block: Block.
    public func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollBack()
        }
    }
    
}
