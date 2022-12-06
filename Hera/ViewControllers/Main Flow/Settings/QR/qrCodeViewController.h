//
//  qrCodeViewController.h
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface qrCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *qrImage;
@property (weak, nonatomic) NSDictionary *qrData;
-(UIImage*)generateQRCodeWithData:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
