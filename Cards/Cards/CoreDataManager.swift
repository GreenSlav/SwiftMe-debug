//
//  CoreDataManager.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Cards")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createAndSaveFCTopic(_ topicName: String) {
        let topic = FlashCardTopic(context: viewContext)
        topic.name = topicName
        
        saveContext()
    }
    
    func saveAndCreateFlashCard(_ flashCardTopic: FlashCardTopic?, question: String, answer: String){
        print(flashCardTopic == nil)
        if flashCardTopic != nil{
            let flashCard = FlashCard(context: viewContext)
            flashCard.question = question
            flashCard.answer = answer
            flashCardTopic?.addToRelationshipCard(flashCard)
            
            saveContext()
            
        }
        
    }
    
    func obtainSavedTopics() -> [FlashCardTopic] {
        let topicRequest = FlashCardTopic.fetchRequest()
        
        let result = try? viewContext.fetch(topicRequest)
        
        return result ?? []
    }
    
    func deleteTopic(_ topic: FlashCardTopic) {
        viewContext.delete(topic)
        
        saveContext()
    }
    
    func deleteFlashCard(_ topic: FlashCardTopic, _ flashCard: FlashCard){
        topic.removeFromRelationshipCard(flashCard)
        saveContext()
    }
    
    func obtainCardsByTopic(_ topic: FlashCardTopic?) -> Set<FlashCard>  {
        return topic?.relationshipCard ?? Set<FlashCard> ()
    }
    
    
}
