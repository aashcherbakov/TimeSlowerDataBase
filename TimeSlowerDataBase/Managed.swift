//
//  Managed.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/22/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

public protocol Managed: class, NSFetchRequestResult {

    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }

}

extension Managed {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }

}

extension Managed where Self: NSManagedObject {

    public static var entityName: String {
        return entity().name!
    }

}
