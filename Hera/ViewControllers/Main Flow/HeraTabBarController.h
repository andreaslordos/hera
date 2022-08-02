//
//  HeraTabBarController.h
//  Hera
//
//  Created by Andreas Lordos on 7/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeraTabBarController : UITabBarController
@property (nonatomic, assign) NSManagedObjectContext* context;
@end

NS_ASSUME_NONNULL_END
