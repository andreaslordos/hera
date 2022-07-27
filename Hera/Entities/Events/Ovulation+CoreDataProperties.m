//
//  Ovulation+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Ovulation+CoreDataProperties.h"

@implementation Ovulation (CoreDataProperties)

+ (NSFetchRequest<Ovulation *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Ovulation"];
}

@dynamic probability;

@end
