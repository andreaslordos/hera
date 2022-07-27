//
//  CurrentCycle+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "CurrentCycle+CoreDataProperties.h"

@implementation CurrentCycle (CoreDataProperties)

+ (NSFetchRequest<CurrentCycle *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CurrentCycle"];
}


@end
