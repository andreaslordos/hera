//
//  CycleCollectionPast+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "CycleCollectionPast+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CycleCollectionPast (CoreDataProperties)

+ (NSFetchRequest<CycleCollectionPast *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSSet<Cycle *> *cycles;

@end

@interface CycleCollectionPast (CoreDataGeneratedAccessors)

- (void)addCyclesObject:(Cycle *)value;
- (void)removeCyclesObject:(Cycle *)value;
- (void)addCycles:(NSSet<Cycle *> *)values;
- (void)removeCycles:(NSSet<Cycle *> *)values;

@end

NS_ASSUME_NONNULL_END
