//
//  User+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic averageOvulationDuration;
@dynamic averageOvulationStart;
@dynamic averagePeriodDuration;
@dynamic faceIdEnabled;
@dynamic isSynced;
@dynamic lastBackup;
@dynamic lastCycleStart;
@dynamic cycles;
@dynamic events;

@end
