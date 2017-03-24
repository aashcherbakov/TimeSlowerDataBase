//
//  Activity.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/22/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

public final class Activity: NSManagedObject {

    // MARK: - Public properties

    @NSManaged public fileprivate(set) var name: String
    @NSManaged public fileprivate(set) var resourceId: String

    public fileprivate(set) var type: ActivityType {
        get { return createType(from: activityType) }
        set { activityType = newValue.rawValue }
    }

    // MARK: - Private properties

    @NSManaged private var activityType: Int16

    // MARK: - Public functions

    static func insert(withName name: String, type: ActivityType, into context: NSManagedObjectContext) -> Activity {
        let activity: Activity = context.insertObject()
        activity.name = name
        activity.type = type
        activity.resourceId = "id"
        return activity
    }

    // MARK: - Private unctions

    private func createType(from value: Int16) -> ActivityType {
        guard let type = ActivityType(rawValue: value) else {
            fatalError("Unrecognized activity type")
        }

        return type
    }

}

extension Activity: Managed {

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: false)]
    }

}
