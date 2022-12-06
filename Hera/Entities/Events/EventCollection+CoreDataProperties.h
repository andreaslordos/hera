//
//  EventCollection+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "EventCollection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EventCollection (CoreDataProperties)

+ (NSFetchRequest<EventCollection *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSOrderedSet<Event *> *event;

@end

@interface EventCollection (CoreDataGeneratedAccessors)

- (void)insertObject:(Event *)value inEventAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEventAtIndex:(NSUInteger)idx;
- (void)insertEvent:(NSArray<Event *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEventAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEventAtIndex:(NSUInteger)idx withObject:(Event *)value;
- (void)replaceEventAtIndexes:(NSIndexSet *)indexes withEvent:(NSArray<Event *> *)values;
- (void)addEventObject:(Event *)value;
- (void)removeEventObject:(Event *)value;
- (void)addEvent:(NSOrderedSet<Event *> *)values;
- (void)removeEvent:(NSOrderedSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
