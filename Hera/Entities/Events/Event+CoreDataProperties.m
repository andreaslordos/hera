//
//  Event+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Event"];
}

@dynamic date;
@dynamic predicted;
@dynamic type;

@end
