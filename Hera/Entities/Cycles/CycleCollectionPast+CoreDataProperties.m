//
//  CycleCollectionPast+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "CycleCollectionPast+CoreDataProperties.h"

@implementation CycleCollectionPast (CoreDataProperties)

+ (NSFetchRequest<CycleCollectionPast *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CycleCollectionPast"];
}

@dynamic cycles;

@end
