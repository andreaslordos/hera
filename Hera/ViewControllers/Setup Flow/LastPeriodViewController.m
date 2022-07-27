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

@interface LastPeriodViewController ()
@property (weak) NSManagedObjectContext* context;
@property (strong) User* user;
@end

@implementation LastPeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datepicker.maximumDate = [NSDate date]; // set max date to today
    [self setObjectContext];
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


- (void) setObjectContext {
    _context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
            self.context = [delegate managedObjectContext];
    }
}

- (void)finishLastPeriod {
    [self performSegueWithIdentifier:@"finishLastPeriod" sender:self];
}

- (IBAction)didTapNotSure:(id)sender {
    [self finishLastPeriod];
}

- (IBAction)didTapContinue:(id)sender {
    self.user.lastCycleStart = [self.datepicker date];
    [self finishLastPeriod];
}

@end
