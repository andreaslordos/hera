//
//  EventCollection+CoreDataClass.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface EventCollection : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "EventCollection+CoreDataProperties.h"
