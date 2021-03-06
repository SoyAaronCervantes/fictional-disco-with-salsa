//
//  AppDelegate.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      return true
  }
  
  func people() -> [ Person ] {
    let fetchRequest = NSFetchRequest<Person>( entityName: "Person" )
    var personArray = [ Person ]()
    do {

      personArray = try persistentContainer.viewContext.fetch( fetchRequest )

    } catch {

      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")

    }
    
    return personArray

  }

  lazy var persistentContainer: NSPersistentContainer = {
      /*
       The persistent container for the application. This implementation
       creates and returns a container, having loaded the store for the
       application to it. This property is optional since there are legitimate
       error conditions that could cause the creation of the store to fail.
      */
      let container = NSPersistentContainer(name: "Compatibility")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               
              /*
               Typical reasons for an error here include:
               * The parent directory does not exist, cannot be created, or disallows writing.
               * The persistent store is not accessible, due to permissions or data protection when the device is locked.
               * The device is out of space.
               * The store could not be migrated to the current model version.
               Check the error message to determine what the actual problem was.
               */
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () -> Bool {
      let context = persistentContainer.viewContext

    if context.hasChanges {
          do {

            try context.save()
            return true

          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
    return false
  }
  
  
  func personByState(_ state: String ) -> [Person] {

    let fetchRequest = NSFetchRequest<Person>( entityName: "Person" )

    var people = [Person]()

    let filter = NSPredicate(format: "state == %@", state )

    fetchRequest.predicate = filter

    do {

      people = try persistentContainer.viewContext.fetch( fetchRequest )

    }

    catch {

      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")

    }

    return people

  }


}

