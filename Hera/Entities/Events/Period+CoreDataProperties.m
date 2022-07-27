//
//  Period+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Period+CoreDataProperties.h"

@implementation Period (CoreDataProperties)

+ (NSFetchRequest<Period *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Period"];
}

@dynamic intensity;

@end
