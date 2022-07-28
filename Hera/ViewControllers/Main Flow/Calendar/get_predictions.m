//
//  get_predictions.m
//  Hera
//
//  Created by Andreas Lordos on 7/25/22.
//

#import "get_predictions.h"
#import "User+CoreDataClass.h"
#import "CycleCollectionFuture+CoreDataClass.h"
#import "CycleCollectionPast+CoreDataClass.h"
#import "Cycle+CoreDataClass.h"
#import "Utilities.h"
@implementation get_predictions

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (NSDate *)getDate:(int)year monthOffset:(int)month dayOffset:(int)day date:(NSDate *)date {
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:year];
    [offsetComponents setMonth:month];
    [offsetComponents setDay:day];
    return [self.gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
}

- (void)setDefaults {
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.cycleStartDate = self.user.lastCycleStart;
    self.ovulationStart = (int) self.user.averageOvulationStart;
    self.ovulationDuration = (int) self.user.averageOvulationDuration;
    self.periodDuration = (int) self.user.averagePeriodDuration;
    self.cycleLength = (int)[Utilities getDaysBetween:self.cycleStartDate toDate:[self.user.cyclesFuture.cycles firstObject].endDate];
}

- (NSString*)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (NSDictionary*)getOvulation {
    return [self getEventWithDuration:self.ovulationDuration eventStart:14];
}

- (NSDictionary*)getPeriod {
    return [self getEventWithDuration:self.periodDuration eventStart:0];

}

-(NSDictionary*)getEventWithDuration:(int)eventDuration eventStart:(int)eventStart {
    NSDate *nextStartDate = self.cycleStartDate;
    NSDate *firstDay = [self getDate:0 monthOffset:0 dayOffset:eventStart date:nextStartDate]; // start of event
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:100];
    for (int i = 0; i < 20; i++) {
        for (int j = 0; j < eventDuration; j++) {
            float probability = 1-abs((j-((eventDuration-1)/2)))/((float)eventDuration);
            [returnDict setObject:[NSNumber numberWithFloat:probability] forKey:[self formatDate:[self getDate:0 monthOffset:0 dayOffset:j date:firstDay]]];
        }
        firstDay = [self getDate:0 monthOffset:0 dayOffset:self.cycleLength date:firstDay];
    }
    return returnDict;
}

@end
