//
//  CurrentCycle+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "CurrentCycle+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CurrentCycle (CoreDataProperties)

+ (NSFetchRequest<CurrentCycle *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());


@end

NS_ASSUME_NONNULL_END
