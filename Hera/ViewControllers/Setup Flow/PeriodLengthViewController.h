//
//  PeriodLengthViewController.h
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeriodLengthViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker; // picker for period length
- (IBAction)didTapContinue:(id)sender;
- (IBAction)didTapNotSure:(id)sender;
@end

NS_ASSUME_NONNULL_END
