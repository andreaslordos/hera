//
//  Cycle+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "Cycle+CoreDataProperties.h"

@implementation Cycle (CoreDataProperties)

+ (NSFetchRequest<Cycle *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Cycle"];
}

@dynamic endDate;
@dynamic ovulationDuration;
@dynamic ovulationStart;
@dynamic periodDuration;
@dynamic startDate;
@dynamic events;

@end
