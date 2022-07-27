//
//  CycleCollection+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "CycleCollection+CoreDataProperties.h"

@implementation CycleCollection (CoreDataProperties)

+ (NSFetchRequest<CycleCollection *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CycleCollection"];
}

@dynamic cycles;
@dynamic relationship;

@end
