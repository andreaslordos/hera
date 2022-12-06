//
//  TermsAndConditions.h
//  Hera
//
//  Created by Andreas Lordos on 7/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TermsAndConditionsVCDelegate

@end

@interface TermsAndConditionsVC : UIViewController
- (IBAction)didTapTerms:(id)sender;
@property (nonatomic, weak) id<TermsAndConditionsVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
