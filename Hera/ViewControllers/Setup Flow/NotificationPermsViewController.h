//
//  NotificationPermsViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/14/22.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationPermsViewController : UIViewController
@property (nonatomic, assign) User *user;
@property (nonatomic, assign) NSManagedObjectContext *context;
@end

NS_ASSUME_NONNULL_END
