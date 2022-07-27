//
//  Period+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Period+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Period (CoreDataProperties)

+ (NSFetchRequest<Period *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) float intensity;

@end

NS_ASSUME_NONNULL_END
