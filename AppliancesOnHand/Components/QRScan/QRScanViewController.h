//
//  QRScanViewController.h
//  bike2day
//
//  Created by DEVTAB_006 on 12/25/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "BaseViewController.h"
#import <LBXScan/LBXScanWrapper.h>
#import <LBXScan/LBXScanViewStyle.h>
#import <LBXScan/LBXScanView.h>
@class Product;

@interface QRScanViewController : BaseViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) LBXScanWrapper* scanObj;
@property (nonatomic,strong) LBXScanView* qRScanView;
@property (nonatomic, strong) LBXScanViewStyle *style;

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) NSString *productId;

@property(nonatomic,strong)UIImage* scanImage;
@property(nonatomic,assign)BOOL isOpenInterestRect;
@property(nonatomic,assign)BOOL isOpenFlash;

- (void)openLocalPhoto;
- (void)openOrCloseFlash;

@property (nonatomic, strong) UIView *bottomItemsView;
@property (nonatomic, strong) UIButton *btnPhoto;
@property (nonatomic, strong) UIButton *btnFlash;
@property (nonatomic, strong) UIButton *btnMyQR;

@end
