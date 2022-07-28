//
//  HeraTabBarController.m
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//

#import "HeraTabBarController.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"
#import "User+CoreDataClass.h"
#import "Utilities.h"
@interface HeraTabBarController ()
@end

@implementation HeraTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.context = [Utilities getObjectContext]; // load object context only AFTER login / auth is completed.
}

@end
