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

@property (nullable, nonatomic, retain) NSOrderedSet<Cycle *> *cycles;

@end

@interface CycleCollectionPast (CoreDataGeneratedAccessors)

- (void)insertObject:(Cycle *)value inCyclesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCyclesAtIndex:(NSUInteger)idx;
- (void)insertCycles:(NSArray<Cycle *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCyclesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCyclesAtIndex:(NSUInteger)idx withObject:(Cycle *)value;
- (void)replaceCyclesAtIndexes:(NSIndexSet *)indexes withCycles:(NSArray<Cycle *> *)values;
- (void)addCyclesObject:(Cycle *)value;
- (void)removeCyclesObject:(Cycle *)value;
- (void)addCycles:(NSOrderedSet<Cycle *> *)values;
- (void)removeCycles:(NSOrderedSet<Cycle *> *)values;

@end

NS_ASSUME_NONNULL_END
