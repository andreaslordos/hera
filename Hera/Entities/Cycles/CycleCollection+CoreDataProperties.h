//
//  CycleCollection+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "CycleCollection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CycleCollection (CoreDataProperties)

+ (NSFetchRequest<CycleCollection *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSObject *cycles;
@property (nullable, nonatomic, retain) NSOrderedSet<Cycle *> *relationship;

@end

@interface CycleCollection (CoreDataGeneratedAccessors)

- (void)insertObject:(Cycle *)value inRelationshipAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRelationshipAtIndex:(NSUInteger)idx;
- (void)insertRelationship:(NSArray<Cycle *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRelationshipAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRelationshipAtIndex:(NSUInteger)idx withObject:(Cycle *)value;
- (void)replaceRelationshipAtIndexes:(NSIndexSet *)indexes withRelationship:(NSArray<Cycle *> *)values;
- (void)addRelationshipObject:(Cycle *)value;
- (void)removeRelationshipObject:(Cycle *)value;
- (void)addRelationship:(NSOrderedSet<Cycle *> *)values;
- (void)removeRelationship:(NSOrderedSet<Cycle *> *)values;

@end

NS_ASSUME_NONNULL_END
