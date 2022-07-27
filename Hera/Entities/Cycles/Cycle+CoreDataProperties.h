//
//  Cycle+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "Cycle+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Cycle (CoreDataProperties)

+ (NSFetchRequest<Cycle *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nonatomic) int16_t ovulationDuration;
@property (nullable, nonatomic, copy) NSDate *ovulationStart;
@property (nonatomic) int16_t periodDuration;
@property (nullable, nonatomic, copy) NSDate *startDate;

@end

NS_ASSUME_NONNULL_END
