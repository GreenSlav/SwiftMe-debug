//
//  FlashCardTopic+CoreDataProperties.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//
//

import Foundation
import CoreData

public class FlashCardTopic: NSManagedObject {

}

extension FlashCardTopic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardTopic> {
        return NSFetchRequest<FlashCardTopic>(entityName: "FlashCardTopic")
    }

    @NSManaged public var name: String?
    @NSManaged public var relationshipCard: NSSet?

}

// MARK: Generated accessors for relationshipCard
extension FlashCardTopic {

    @objc(addRelationshipCardObject:)
    @NSManaged public func addToRelationshipCard(_ value: FlashCard)

    @objc(removeRelationshipCardObject:)
    @NSManaged public func removeFromRelationshipCard(_ value: FlashCard)

    @objc(addRelationshipCard:)
    @NSManaged public func addToRelationshipCard(_ values: NSSet)

    @objc(removeRelationshipCard:)
    @NSManaged public func removeFromRelationshipCard(_ values: NSSet)

}

extension FlashCardTopic : Identifiable {

}
