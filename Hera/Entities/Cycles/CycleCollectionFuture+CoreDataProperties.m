//
//  CycleCollectionFuture+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "CycleCollectionFuture+CoreDataProperties.h"

@implementation CycleCollectionFuture (CoreDataProperties)

+ (NSFetchRequest<CycleCollectionFuture *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CycleCollectionFuture"];
}

@dynamic cycles;

@end
