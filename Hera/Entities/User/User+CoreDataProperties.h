//
//  User+CoreDataProperties.h
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
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
@property (nullable, nonatomic, retain) CycleCollectionFuture *cyclesFuture;
@property (nullable, nonatomic, retain) CycleCollectionPast *cyclesPast;

@end

NS_ASSUME_NONNULL_END
