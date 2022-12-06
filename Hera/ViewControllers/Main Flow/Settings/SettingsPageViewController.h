//
//  SettingsPageViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import <UIKit/UIKit.h>
#import "qrScannerViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SettingsPageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, qrScannerViewControllerDelegate>
@property (strong, atomic) NSDictionary* QRdata;
@end

NS_ASSUME_NONNULL_END
