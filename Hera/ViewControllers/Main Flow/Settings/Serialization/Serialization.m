//
//  Serialization.m
//  Hera
//
//  Created by Andreas Lordos on 8/3/22.
//

#import "Serialization.h"
#import "Cycle+CoreDataClass.h"
#import "CycleCollectionFuture+CoreDataClass.h"
#import "CycleCollectionPast+CoreDataClass.h"
#import "EventCollection+CoreDataClass.h"
#import "Event+CoreDataClass.h"
#import "Period+CoreDataClass.h"
#import "Pain+CoreDataClass.h"
#import "Mood+CoreDataClass.h"
#import "Ovulation+CoreDataClass.h"
#import "Utilities.h"

@implementation Serialization

+(NSDictionary*)EntityToSerial:(NSManagedObject*)obj {
    NSArray *attributeKeys = [[[obj entity] attributesByName] allKeys];
    NSDictionary *dictAttributes = [self serializeDates:[obj dictionaryWithValuesForKeys:attributeKeys]];
    return dictAttributes;
}

+(NSMutableDictionary*)serializeDates:(NSDictionary*)dict {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *newString;
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSMutableDictionary *mDict = [dict mutableCopy];
    NSArray *keys = [mDict allKeys];
    for(NSString *key in keys) {
        if ([[mDict objectForKey:key] isKindOfClass:[NSDate class]]) {
            newString = [dateFormat stringFromDate:[mDict objectForKey:key]];
            [mDict setObject:newString forKey:key];
        }
    }
    return mDict;
}

+(NSDate*)deserializeDate:(NSString*)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    @try  {
        NSDate *date = [dateFormat dateFromString:dateString];
        return date;
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return nil;
    }
    @finally  {
    }
}
+(NSData*)serializeUser:(User*)user {
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    NSDictionary *dictAttributes = [self EntityToSerial:user];
    [json setObject:dictAttributes forKey:@"userAttributes"];

    NSArray *futureCycles = [user.cyclesFuture.cycles array];
    NSArray *pastCycles = [user.cyclesPast.cycles array];
    NSArray *allCycles = [NSArray arrayWithObjects:pastCycles, futureCycles, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"pastCycles", @"futureCycles", nil];
    for (int a = 0; a < [allCycles count]; a++) {
        NSMutableArray *cyclesArr = [NSMutableArray array];
        for (int i = 0; i < [allCycles[a] count]; i++) {
            Cycle *currentCycle = allCycles[a][i];
            NSDictionary *cycleAttributes = [self EntityToSerial:currentCycle];
            NSMutableArray *serializedCycle = [NSMutableArray array];
            NSArray *currentEvents = [currentCycle.events.event array];
            for (int j = 0; j < [currentEvents count]; j++) {
                Event *currentEvent = currentEvents[j];
                NSDictionary *dictEvent = [self EntityToSerial:currentEvent];
                [serializedCycle addObject:dictEvent];
            }
            NSDictionary *completeCycle = [NSDictionary dictionaryWithObjectsAndKeys:serializedCycle, @"cycleEvents", cycleAttributes, @"cycleAttributes", nil];
            [cyclesArr addObject:completeCycle];
        }
        [json setObject:cyclesArr forKey:keys[a]];
    }
    NSData *jsonData = [Utilities dictToJson:json];
    return jsonData;
}


+(void)deserializeUser:(NSDictionary*)userDict context:(NSManagedObjectContext*)context{
    NSLog(@"%@", userDict);
    User *user = [[User alloc] initWithContext:context];
    NSDictionary *userAttributes = [userDict objectForKey:@"userAttributes"];
    NSArray *futureCycles = [userDict objectForKey:@"futureCycles"];
    NSArray *pastCycles = [userDict objectForKey:@"pastCycles"];
    
    // set user attributes
    user.lastBackup = [self deserializeDate:[userAttributes objectForKey:@"lastBackup"]];
    user.isSynced = ([[userAttributes objectForKey:@"isSynced"] longValue] == 1);
    user.faceIdEnabled = ([[userAttributes objectForKey:@"faceIdEnabled"] longValue] == 1);
    user.lastCycleStart = [self deserializeDate:[userAttributes objectForKey:@"lastCycleStart"]];
    user.averagePeriodDuration = [[userAttributes objectForKey:@"averagePeriodDuration"] floatValue];
    user.averageOvulationStart = [[userAttributes objectForKey:@"averageOvulationStart"] floatValue];
    user.averageOvulationDuration = [[userAttributes objectForKey:@"averageOvulationDuration"] floatValue];
    
    CycleCollectionFuture *futureCyclesEnt = [[CycleCollectionFuture alloc] initWithContext:context];
    CycleCollectionPast *pastCyclesEnt = [[CycleCollectionPast alloc] initWithContext:context];
    
    NSArray *cycleEnts = [NSArray arrayWithObjects:pastCyclesEnt, futureCyclesEnt, nil];
    NSArray *cycleArrays = [NSArray arrayWithObjects:pastCycles, futureCycles, nil];
    for (int z = 0; z < [cycleEnts count]; z++) {
        NSArray *currentCycleArr = cycleArrays[z];
        for (int a = 0; a < [currentCycleArr count]; a++) {
            NSDictionary *currentCycle = currentCycleArr[a];
            NSArray *cycleEvents = [currentCycle objectForKey:@"cycleEvents"];
            NSDictionary *cycleAttributes = [currentCycle objectForKey:@"cycleAttributes"];
            Cycle *cycle = [[Cycle alloc] initWithContext:context];
            
            // set cycle attributes
            cycle.startDate = [self deserializeDate:[cycleAttributes objectForKey:@"startDate"]];
            cycle.endDate = [self deserializeDate:[cycleAttributes objectForKey:@"endDate"]];
            cycle.ovulationStart = [self deserializeDate:[cycleAttributes objectForKey:@"ovulationStart"]];
            cycle.periodDuration = [[cycleAttributes objectForKey:@"periodDuration"] intValue];
            cycle.ovulationDuration = [[cycleAttributes objectForKey:@"ovulationDuration"] intValue];
            
            // set cycle events
            cycle.events = [[EventCollection alloc] initWithContext:context];
            for (int i = 0; i < [cycleEvents count]; i++) {
                if ([[cycleEvents[i] objectForKey:@"type"] intValue] == 0) {
                    // period
                    Period *periodEvent = [[Period alloc] initWithContext:context];
                    periodEvent.intensity = [[cycleEvents[i] objectForKey:@"intensity"] floatValue];
                    periodEvent.type = [[cycleEvents[i] objectForKey:@"type"] intValue];
                    periodEvent.date = [self deserializeDate:[cycleEvents[i] objectForKey:@"date"]];
                    periodEvent.predicted = [[cycleEvents[i] objectForKey:@"predicted"] boolValue];
                    [cycle.events insertEventOrderedByDate:periodEvent];
                }
                else if ([[cycleEvents[i] objectForKey:@"type"] intValue] == 1) {
                    // ovulation
                    Ovulation *ovulationEvent = [[Ovulation alloc] initWithContext:context];
                    ovulationEvent.probability = [[cycleEvents[i] objectForKey:@"probability"] floatValue];
                    ovulationEvent.type = [[cycleEvents[i] objectForKey:@"type"] intValue];
                    ovulationEvent.date = [self deserializeDate:[cycleEvents[i] objectForKey:@"date"]];
                    ovulationEvent.predicted = [[cycleEvents[i] objectForKey:@"predicted"] boolValue];
                    [cycle.events insertEventOrderedByDate:ovulationEvent];
                }
                else if ([[cycleEvents[i] objectForKey:@"type"] intValue] == 2) {
                    // mood
                    Mood *moodEvent = [[Mood alloc] initWithContext:context];
                    moodEvent.type = [[cycleEvents[i] objectForKey:@"type"] intValue];
                    moodEvent.date = [self deserializeDate:[cycleEvents[i] objectForKey:@"date"]];
                    moodEvent.predicted = [[cycleEvents[i] objectForKey:@"predicted"] boolValue];
                    [cycle.events insertEventOrderedByDate:moodEvent];
                }
                else if ([[cycleEvents[i] objectForKey:@"type"] intValue] == 3) {
                    // pain
                    Pain *painEvent = [[Pain alloc] initWithContext:context];
                    painEvent.type = [[cycleEvents[i] objectForKey:@"type"] intValue];
                    painEvent.date = [self deserializeDate:[cycleEvents[i] objectForKey:@"date"]];
                    painEvent.predicted = [[cycleEvents[i] objectForKey:@"predicted"] boolValue];
                    [cycle.events insertEventOrderedByDate:painEvent];
                }
            }
            // add cycle to cycle ent
            if (z == 0) { // to past cycle ent
                [pastCyclesEnt addCyclesObject:cycle];
            }
            else { // to future cycles ent
                [futureCyclesEnt addCyclesObject:cycle];
            }
        }
    }
    [context save:nil]; // save new user context
}


@end
