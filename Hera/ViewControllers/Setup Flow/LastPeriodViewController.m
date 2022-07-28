//
//  LastPeriodViewController.m
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import "LastPeriodViewController.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"
#import "User+CoreDataClass.h"
#import "PeriodLengthViewController.h"
#import "CycleCollectionFuture+CoreDataClass.h"
#import "CycleCollectionPast+CoreDataClass.h"

#import "Cycle+CoreDataClass.h"
#import "Utilities.h"
#import "EventCollection+CoreDataClass.h"
#import "Event+CoreDataClass.h"
#import "Period+CoreDataClass.h"
#import "Ovulation+CoreDataClass.h"

@interface LastPeriodViewController ()
@property (weak) NSManagedObjectContext* context;
@property (strong) User* user;
@end

@implementation LastPeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datepicker.maximumDate = [NSDate date]; // set max date to today
    self.context = [Utilities getObjectContext];
    self.user = [[User alloc] initWithContext:self.context];
    self.user.lastCycleStart = nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"finishLastPeriod"]) {
        PeriodLengthViewController *controller = (PeriodLengthViewController*)segue.destinationViewController;
        controller.user = self.user;
        controller.context = self.context;
    }
}

- (void)finishLastPeriod {
    [self performSegueWithIdentifier:@"finishLastPeriod" sender:self];
}

- (IBAction)didTapNotSure:(id)sender {
    [self finishLastPeriod];
}

- (void)initializePeriodWithDate:(NSDate*)periodDate {
    self.user.lastCycleStart = periodDate;
    self.user.cyclesFuture = [[CycleCollectionFuture alloc] initWithContext:self.context];
    self.user.averageOvulationStart = 8.0;
    self.user.averageOvulationDuration = 7.0;
    
    Cycle *cycle = [[Cycle alloc] initWithContext:self.context];
    cycle.events = [[EventCollection alloc] initWithContext:self.context];
    cycle.startDate = periodDate;
    cycle.ovulationStart = [Utilities getDateByYearOffset:0 monthOffset:0 dayOffset:(int) self.user.averageOvulationStart date:cycle.startDate]; // default ovulation start
    cycle.ovulationDuration = (int) self.user.averageOvulationDuration; // days with probability of ovulation
    cycle.endDate = [Utilities getDateByYearOffset:0 monthOffset:0 dayOffset:28 date:cycle.startDate]; // default cycle duration 29 days

    float startingProb = 0.2;
    float oldMax = (cycle.ovulationDuration - 1.0) * (cycle.ovulationDuration - 1.0) * 2.0;
    float modifier = (oldMax / (1-startingProb)) - oldMax;
    float newMax = oldMax + modifier;
    
    for (int i = 0; i < cycle.ovulationDuration; i++) {
        Ovulation *ovulationEvent = [[Ovulation alloc] initWithContext:self.context];
        ovulationEvent.date = [Utilities getDateByYearOffset:0 monthOffset:0 dayOffset:i date:cycle.ovulationStart];
        ovulationEvent.probability = ((-1 * i * (i + 2 - (2 * cycle.ovulationDuration))) + modifier) / newMax; // (-(x)(x+2-2ovuldur) + modifier) / max
        ovulationEvent.type = 1; // ovulation type
        ovulationEvent.predicted = YES;
        [cycle.events insertEventOrderedByDate:ovulationEvent];
    }
    
    Period *periodEvent = [[Period alloc] initWithContext:self.context];
    periodEvent.date = periodDate;
    periodEvent.type = 0;
    periodEvent.intensity = 0.5;
    periodEvent.predicted = NO;
    
    [cycle.events insertEventOrderedByDate:periodEvent];
    
    CycleCollectionFuture *futureCycles = [[CycleCollectionFuture alloc] initWithContext:self.context];
    CycleCollectionPast *pastCycles = [[CycleCollectionPast alloc] initWithContext:self.context];
    
    [futureCycles insertObject:cycle inCyclesAtIndex:0];
    
    self.user.cyclesFuture = futureCycles;
    self.user.cyclesPast = pastCycles;

    
    NSLog(@"Count in LastPeriod: %lu", (unsigned long)[self.user.cyclesFuture.cycles count]);
    NSLog(@"First object in LastPeriod: %@", [self.user.cyclesFuture.cycles firstObject]);
    
}

- (IBAction)didTapContinue:(id)sender {
    [self initializePeriodWithDate:[self.datepicker date]];
    [self finishLastPeriod];
}

@end
