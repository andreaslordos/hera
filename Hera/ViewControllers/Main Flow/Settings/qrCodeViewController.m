//
//  qrCodeViewController.m
//  Hera
//
//  Created by Andreas Lordos on 8/1/22.
//

#import "qrCodeViewController.h"

@interface qrCodeViewController ()

@end

@implementation qrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView setImage:self.qrImage];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
