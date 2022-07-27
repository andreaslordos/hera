//
//  Mood+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Mood+CoreDataProperties.h"

@implementation Mood (CoreDataProperties)

+ (NSFetchRequest<Mood *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Mood"];
}


@end
