//
//  StartupViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/15/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartupViewController : UINavigationController
@property (nonatomic, assign) NSManagedObjectContext* context;
@end

NS_ASSUME_NONNULL_END
