//
//  Pain+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Pain+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Pain (CoreDataProperties)

+ (NSFetchRequest<Pain *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());


@end

NS_ASSUME_NONNULL_END
