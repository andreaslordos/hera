//
//  get_predictions.h
//  Hera
//
//  Created by Andreas Lordos on 7/25/22.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface get_predictions : NSObject
@property (weak, nonatomic) User* user;
@property (nonatomic) int cycleLength;
@property (weak, nonatomic) NSDate* cycleStartDate;
@property int periodDuration;
@property int ovulationDuration;
@property int ovulationStart;
- (NSDate *)getDate:(int)year monthOffset:(int)month dayOffset:(int)day date:(NSDate *)date;
- (NSMutableDictionary *)getPeriod;
- (NSMutableDictionary *)getOvulation;
@property NSCalendar *gregorian;
@end

NS_ASSUME_NONNULL_END
