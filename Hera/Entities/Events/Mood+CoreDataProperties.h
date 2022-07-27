//
//  Mood+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Mood+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Mood (CoreDataProperties)

+ (NSFetchRequest<Mood *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());


@end

NS_ASSUME_NONNULL_END
