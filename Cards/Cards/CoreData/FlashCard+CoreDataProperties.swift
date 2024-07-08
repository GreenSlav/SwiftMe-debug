//
//  FlashCard+CoreDataProperties.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//
//

import Foundation
import CoreData

public class FlashCard: NSManagedObject {

}

extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var relationshipCardTopic: FlashCardTopic?

}

extension FlashCard : Identifiable {

}
