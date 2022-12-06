//
//  qrScannerViewController.h
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol qrScannerViewControllerDelegate

- (void)didScan:(NSDictionary *)dict;

@end

@interface qrScannerViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewforCamera;
-(BOOL)startReading;
-(void)stopReading:(id)sender;
@property (nonatomic) BOOL isReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) NSDictionary* QRdata;
@property (nonatomic, weak) id<qrScannerViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
