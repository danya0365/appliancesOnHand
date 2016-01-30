//
//  QRScanNotFoundViewController.m
//  bike2day
//
//  Created by DEVTAB_006 on 1/21/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "QRScanNotFoundViewController.h"

@interface QRScanNotFoundViewController ()

@end

@implementation QRScanNotFoundViewController

- (CGSize)preferredContentSize {
    return CGSizeMake(280, 200);
}

-(void)loadViewFromInit
{
    //self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if ( [_delegate respondsToSelector:@selector(qrScanNotFoundViewControllerDidClose:)]) {
            [_delegate qrScanNotFoundViewControllerDidClose:self];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.wrapperView.backgroundColor = [UIColor clearColor];
    self.confirmButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.confirmButton.layer.borderWidth = 2.0f;
    self.confirmButton.layer.cornerRadius = 7.0f;
    [self.confirmButton setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmButtonAction:(id)sender {
    
    [self dismiss];
}

@end
