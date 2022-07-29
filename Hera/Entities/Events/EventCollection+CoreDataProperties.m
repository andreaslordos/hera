//
//  EventCollection+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "EventCollection+CoreDataProperties.h"

@implementation EventCollection (CoreDataProperties)

+ (NSFetchRequest<EventCollection *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"EventCollection"];
}

@dynamic event;

@end
