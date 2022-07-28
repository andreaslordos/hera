//
//  EventCollection+CoreDataClass.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

NS_ASSUME_NONNULL_BEGIN

@interface EventCollection : NSManagedObject
-(void)insertEventOrderedByDate:(Event*)eventToAdd;
@end

NS_ASSUME_NONNULL_END

#import "EventCollection+CoreDataProperties.h"
