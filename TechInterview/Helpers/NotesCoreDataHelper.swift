//
//  NotesCoreDataHelper.swift
//  TechInterview
//
//  Created by Anton Smirnov on 20.01.2022.
//

import Foundation
import CoreData

class NotesCoreDataHelper {
    
    private(set) static var count: Int = 0
    
    static func createNoteInCoreData(
        noteToBeCreated:          NotesModelData,
        intoManagedObjectContext: NSManagedObjectContext) {
        
        let noteEntity = NSEntityDescription.entity(
            forEntityName: "Note",
            in:            intoManagedObjectContext)!
        
        let newNoteToBeCreated = NSManagedObject(
            entity:     noteEntity,
            insertInto: intoManagedObjectContext)
        
        newNoteToBeCreated.setValue(
            noteToBeCreated.noteId,
            forKey: "noteId")
        
        newNoteToBeCreated.setValue(
            noteToBeCreated.noteTitle,
            forKey: "noteTitle")
        
        newNoteToBeCreated.setValue(
            noteToBeCreated.noteText,
            forKey: "noteText")
        
        newNoteToBeCreated.setValue(
            noteToBeCreated.noteTimeStamp,
            forKey: "noteTimeStamp")
        
        do {
            try intoManagedObjectContext.save()
            count += 1
        } catch let error as NSError {
            // TODO error handling
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func readNotesFromCoreData(fromManagedObjectContext: NSManagedObjectContext) -> [NotesModelData] {
        
        var returnedNotes = [NotesModelData]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = nil
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            fetchedNotesFromCoreData.forEach { (fetchRequestResult) in
                let noteManagedObjectRead = fetchRequestResult as! NSManagedObject
                returnedNotes.append(NotesModelData.init(
                                        noteId:        noteManagedObjectRead.value(forKey: "noteId")        as! UUID,
                                        noteTitle:     noteManagedObjectRead.value(forKey: "noteTitle")     as! String,
                                        noteText:      noteManagedObjectRead.value(forKey: "noteText")      as! String,
                                        noteTimeStamp: noteManagedObjectRead.value(forKey: "noteTimeStamp") as! Int64))
            }
        } catch let error as NSError {
            // TODO error handling
            print("Could not read. \(error), \(error.userInfo)")
        }
        
        // set note count
        self.count = returnedNotes.count
        
        return returnedNotes
    }
    
    static func deleteNoteFromCoreData(
        noteIdToBeDeleted:        UUID,
        fromManagedObjectContext: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdAsCVarArg: CVarArg = noteIdToBeDeleted as CVarArg
        let noteIdPredicate = NSPredicate(format: "noteId == %@", noteIdAsCVarArg)
        
        fetchRequest.predicate = noteIdPredicate
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            let noteManagedObjectToBeDeleted = fetchedNotesFromCoreData[0] as! NSManagedObject
            fromManagedObjectContext.delete(noteManagedObjectToBeDeleted)
            
            do {
                try fromManagedObjectContext.save()
                self.count -= 1
            } catch let error as NSError {
                // TODO error handling
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            // TODO error handling
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    static func readNoteFromCoreData(
        noteIdToBeRead:           UUID,
        fromManagedObjectContext: NSManagedObjectContext) -> NotesModelData? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdPredicate = NSPredicate(format: "noteId = %@", noteIdToBeRead as CVarArg)
        
        fetchRequest.predicate = noteIdPredicate
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            let noteManagedObjectToBeRead = fetchedNotesFromCoreData[0] as! NSManagedObject
            return NotesModelData.init(
                noteId:        noteManagedObjectToBeRead.value(forKey: "noteId")        as! UUID,
                noteTitle:     noteManagedObjectToBeRead.value(forKey: "noteTitle")     as! String,
                noteText:      noteManagedObjectToBeRead.value(forKey: "noteText")      as! String,
                noteTimeStamp: noteManagedObjectToBeRead.value(forKey: "noteTimeStamp") as! Int64)
        } catch let error as NSError {
            // TODO error handling
            print("Could not read. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    static func changeNoteInCoreData(
        noteToBeChanged:        NotesModelData,
        inManagedObjectContext: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdPredicate = NSPredicate(format: "noteId = %@", noteToBeChanged.noteId as CVarArg)
        
        fetchRequest.predicate = noteIdPredicate
        
        do {
            let fetchedNotesFromCoreData = try inManagedObjectContext.fetch(fetchRequest)
            let noteManagedObjectToBeChanged = fetchedNotesFromCoreData[0] as! NSManagedObject
            
            // make the changes
            noteManagedObjectToBeChanged.setValue(
                noteToBeChanged.noteTitle,
                forKey: "noteTitle")
            
            noteManagedObjectToBeChanged.setValue(
                noteToBeChanged.noteText,
                forKey: "noteText")
            
            noteManagedObjectToBeChanged.setValue(
                noteToBeChanged.noteTimeStamp,
                forKey: "noteTimeStamp")
            
            // save
            try inManagedObjectContext.save()
            
        } catch let error as NSError {
            // TODO error handling
            print("Could not change. \(error), \(error.userInfo)")
        }
    }
}
