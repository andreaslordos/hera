//
//  AppDelegate.h
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
- (NSManagedObjectContext*)getContext;

@end

