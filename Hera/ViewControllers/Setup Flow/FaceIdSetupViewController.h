//
//  FaceIdSetupViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceIdSetupViewController : UIViewController
@property (nonatomic, assign) User* user;
@property (nonatomic, assign) NSManagedObjectContext* context;
@end

NS_ASSUME_NONNULL_END
