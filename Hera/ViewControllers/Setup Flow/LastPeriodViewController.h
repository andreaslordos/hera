//
//  LastPeriodViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LastPeriodViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)didTapContinue:(id)sender;
- (IBAction)didTapNotSure:(id)sender;
@end

NS_ASSUME_NONNULL_END
