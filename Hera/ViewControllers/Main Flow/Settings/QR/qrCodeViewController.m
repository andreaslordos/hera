//
//  qrCodeViewController.m
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import "qrCodeViewController.h"
#import "Utilities.h"
@interface qrCodeViewController ()

@end

@implementation qrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrImage = [self generateQRCodeWithData:self.qrData];
    [self.imageView setImage:self.qrImage];
    [self.imageView.layer setMagnificationFilter:kCAFilterNearest]; // make qr code sharp / not blurry
    // Do any additional setup after loading the view.
}

- (UIImage*) generateQRCodeWithData:(NSDictionary*)dict {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [Utilities dictToJson:dict];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    return [UIImage imageWithCIImage:outputImage];
}

@end
