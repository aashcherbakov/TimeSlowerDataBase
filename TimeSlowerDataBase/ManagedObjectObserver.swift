//
//  ManagedObjectObserver.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/23/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation
import CoreData

final class ManagedObjectObserver {
    enum ChangeType {
        case delete
        case update
    }

    init?(object: NSManagedObject, changeHandler: @escaping (ChangeType) -> ()) {
        guard let context = object.managedObjectContext else { return nil }
        token = context.addObjectsDidChangeNotificationObserver { [weak self] note in
            guard let changeType = self?.changeType(of: object, in: note) else { return }
            changeHandler(changeType)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(token)
    }

    // MARK: - Private 

    private var token: NSObjectProtocol!

    private func changeType(of object: NSManagedObject, in note: ObjectsDidChangeNotification) -> ChangeType? {
        let deleted = note.deletedObjects.union(note.invalidatedObjects)
        if note.invalidatedAllObjects || deleted.containsObjectIdentical(to: object) {
            return .delete
        }

        let updated = note.updatedObjects.union(note.refreshedObjects)
        if updated.containsObjectIdentical(to: object) {
            return .update
        }

        return nil
    }
}
