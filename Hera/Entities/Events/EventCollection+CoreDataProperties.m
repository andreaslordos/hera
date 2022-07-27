//
//  EventCollection+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "EventCollection+CoreDataProperties.h"

@implementation EventCollection (CoreDataProperties)

+ (NSFetchRequest<EventCollection *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"EventCollection"];
}

@dynamic collection;
@dynamic past;
@dynamic event;

@end
