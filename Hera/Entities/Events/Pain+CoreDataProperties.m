//
//  Pain+CoreDataProperties.m
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Pain+CoreDataProperties.h"

@implementation Pain (CoreDataProperties)

+ (NSFetchRequest<Pain *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Pain"];
}


@end
