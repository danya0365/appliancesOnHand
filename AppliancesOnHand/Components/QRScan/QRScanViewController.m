//
//  QRScanViewController.m
//  bike2day
//
//  Created by DEVTAB_006 on 12/25/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "QRScanViewController.h"
#import "ScanResultViewController.h"
#import "Product.h"
#import "RWBlurPopover.h"

#import <LBXScan/LBXScanViewStyle.h>
#import <LBXScan/LBXScanResult.h>
#import <LBXScan/LBXScanWrapper.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import "BaseNavigationController.h"
#import "QRScanNotFoundViewController.h"

@interface QRScanViewController () <QRScanNotFoundViewControllerDelegate>

@end

@implementation QRScanViewController

-(void)loadViewFromInit
{
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title = @"";
    
    [self setNavigationBarTransparent];
    
    [self setTransclucentView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self drawScanView];
    
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
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

- (void)setNavigationBarLeftButton {
    
    [self setBarCloseButton];
}

- (void)setNavigationBarRightButton {
    
}

#pragma mark LBXScan
//Draw the scan area
- (void)drawScanView
{
    if (_qRScanView)
    {
        [_qRScanView removeFromSuperview];
        _qRScanView = nil;
    }
    
    CGRect rect = self.view.frame;
    rect.origin = CGPointMake(0, 0);
    
    self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
    [self.view addSubview:_qRScanView];
    
    [_qRScanView startDeviceReadyingWithText:NSLocalizedString(@"qr_starting_the_camera", nil)];
    
}

- (void)reStartDevice
{
    [_scanObj startScan];
}

//Boot Device
- (void)startScan
{
    if ( ![LBXScanWrapper isGetCameraPermission] )
    {
        [self.qRScanView stopDeviceReadying];
        
        [self showError:@"Go to privacy settings in the camera turn on the application permissions"];
        return;
    }
    
    
    
    if (!_scanObj )
    {
        __weak __typeof(self) weakSelf = self;
        // AVMetadataObjectTypeQRCode   AVMetadataObjectTypeEAN13Code
        
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        
        self.scanObj = [[LBXScanWrapper alloc]initWithPreView:self.view
                                              ArrayObjectType:nil
                                                     cropRect:cropRect
                                                      success:^(NSArray<LBXScanResult *> *array){
                                                          [weakSelf scanResultWithArray:array];
                                                      }];
        
        
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [_scanObj startScan];
    
    [_qRScanView stopDeviceReadying];
    
    [_qRScanView startScanAnimation];
    
    
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    [LBXScanWrapper systemVibrate];
    
    [LBXScanWrapper systemSound];
    
    //[self popAlertMsgWithScanResult:strResult];
    
    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"Identification failure";
    }
    
    /*
     __weak __typeof(self) weakSelf = self;
     [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult chooseBlock:^(NSInteger buttonIdx) {
     
     //点击完，继续扫码
     [weakSelf reStartDevice];
     } buttonsStatement:@"知道了",nil];
     */
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    /*
    ScanResultViewController *vc = [ScanResultViewController new];
    vc.imgScan = strResult.imgScanned;
    vc.strScan = strResult.strScanned;
    vc.strCodeType = strResult.strBarCodeType;
    [self.navigationController pushViewController:vc animated:YES];
     */
    
    
    _product = nil;
    _productId = strResult.strScanned;
    
    [self presentProductDetail];

    [self presentProductNotFoundPopover];
    return;
}

-(void)presentProductDetail
{
    /*
    ProductDetailViewController *productDetailViewController = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    productDetailViewController.delegate = self;
    productDetailViewController.productId = _productId;
    productDetailViewController.product = _product;
    BaseNavigationController *baseNavigationController = [[BaseNavigationController alloc] initWithRootViewController:productDetailViewController];
    
    
    //__weak __typeof(self) weakSelf = self;
    [self presentViewController:baseNavigationController animated:YES completion:^{
        //weakSelf.view.alpha = 0.0f;
    }];
     */
}

-(void)presentProductNotFoundPopover
{
    QRScanNotFoundViewController *qrScanNotFoundViewController = [[QRScanNotFoundViewController alloc] initWithNibName:@"QRScanNotFoundViewController" bundle:nil];
    qrScanNotFoundViewController.delegate = self;

    RWBlurPopover *popover = [[RWBlurPopover alloc] initWithContentViewController:qrScanNotFoundViewController];
    popover.throwingGestureEnabled = NO;
    popover.tapBlurToDismissEnabled = NO;
    [popover showInViewController:self.navigationController];
}

#pragma mark - Function items at the bottom
- (void)openPhoto
{
    if ([LBXScanWrapper isGetPhotoPermission])
        [self openLocalPhoto];
    else
    {
        [self showError:@"Go to Settings -> Privacy in turn on the application permissions album"];
    }
}

- (void)openOrCloseFlash
{
    
    [_scanObj openOrCloseFlash];
    
    self.isOpenFlash =!self.isOpenFlash;
    
    if (self.isOpenFlash)
    {
        [self.btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [self.btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


#pragma mark - Open the album and identify pictures
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    
    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXScanWrapper recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
        
        [weakSelf scanResultWithArray:array];
    }];

    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Helper
- (void)showError:(NSString*)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = str;
    [hud hide:YES afterDelay:2.0f];
}

#pragma mark - Delegate

-(void)qrScanNotFoundViewControllerDidClose:(QRScanNotFoundViewController *)viewController
{
    [self drawScanView];
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
}

#pragma mark - Status Bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end
