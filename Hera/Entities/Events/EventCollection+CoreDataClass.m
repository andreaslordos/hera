//
//  EventCollection+CoreDataClass.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//
//

#import "EventCollection+CoreDataClass.h"
#import "Event+CoreDataProperties.h"

@implementation EventCollection

// keeps ordered set ordered by date instead of date of addition
-(void)insertEventOrderedByDate:(Event*)eventToAdd {
    if (self.event.count == 0) {
        [self addEventObject:eventToAdd];
        return;
    }
    for (int i = 0; i < [self.event count]; i++) {
        Event *e = [self.event objectAtIndex:i];
        if (e.date > eventToAdd.date) {
            [self insertObject:eventToAdd inEventAtIndex:i];
            return;
        }
    }
    
    [self addEventObject:eventToAdd];
    return;
}

@end
