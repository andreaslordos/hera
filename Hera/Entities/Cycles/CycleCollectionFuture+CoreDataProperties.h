//
//  CycleCollectionFuture+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "CycleCollectionFuture+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CycleCollectionFuture (CoreDataProperties)

+ (NSFetchRequest<CycleCollectionFuture *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSSet<Cycle *> *cycles;

@end

@interface CycleCollectionFuture (CoreDataGeneratedAccessors)

- (void)addCyclesObject:(Cycle *)value;
- (void)removeCyclesObject:(Cycle *)value;
- (void)addCycles:(NSSet<Cycle *> *)values;
- (void)removeCycles:(NSSet<Cycle *> *)values;

@end

NS_ASSUME_NONNULL_END
