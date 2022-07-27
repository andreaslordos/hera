//
//  User+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/26/22.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) float averageOvulationDuration;
@property (nonatomic) float averageOvulationStart;
@property (nonatomic) float averagePeriodDuration;
@property (nonatomic) BOOL faceIdEnabled;
@property (nonatomic) BOOL isSynced;
@property (nullable, nonatomic, copy) NSDate *lastBackup;
@property (nullable, nonatomic, copy) NSDate *lastCycleStart;
@property (nullable, nonatomic, retain) CycleCollection *cycles;
@property (nullable, nonatomic, retain) NSSet<EventCollection *> *events;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addEventsObject:(EventCollection *)value;
- (void)removeEventsObject:(EventCollection *)value;
- (void)addEvents:(NSSet<EventCollection *> *)values;
- (void)removeEvents:(NSSet<EventCollection *> *)values;

@end

NS_ASSUME_NONNULL_END
