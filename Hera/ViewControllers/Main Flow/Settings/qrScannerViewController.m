//
//  qrScannerViewController.m
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import "qrScannerViewController.h"

@interface qrScannerViewController ()

@end

@implementation qrScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblStatus.text = @"Some text";
    _captureSession = nil;
    _isReading = NO;
    [self startQR];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)startQR {
    if (!_isReading) {
        if ([self startReading]) {
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else {
        [self stopReading];
    }
    _isReading = !_isReading;
}

-(BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
      
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewforCamera.layer.bounds];
    [_viewforCamera.layer addSublayer:_videoPreviewLayer];
    [_captureSession startRunning];

    return YES;
}

-(void)stopReading{
   [_captureSession stopRunning];
   _captureSession = nil;
   [_videoPreviewLayer removeFromSuperlayer];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
   if (metadataObjects != nil && [metadataObjects count] > 0) {
       AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
       if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
           //metadataObj stringValue
           [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
           _isReading = NO;
       }
   }
}


@end
