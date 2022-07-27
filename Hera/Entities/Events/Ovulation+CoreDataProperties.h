//
//  Ovulation+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Ovulation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Ovulation (CoreDataProperties)

+ (NSFetchRequest<Ovulation *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) float probability;

@end

NS_ASSUME_NONNULL_END
