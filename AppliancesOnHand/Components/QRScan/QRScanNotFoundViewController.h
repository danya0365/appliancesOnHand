//
//  QRScanNotFoundViewController.h
//  bike2day
//
//  Created by DEVTAB_006 on 1/21/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "BaseViewController.h"

@class QRScanNotFoundViewController;

@protocol QRScanNotFoundViewControllerDelegate <NSObject>

-(void)qrScanNotFoundViewControllerDidClose: (QRScanNotFoundViewController *)viewController;
@end

@interface QRScanNotFoundViewController : BaseViewController

@property (nonatomic, weak) id<QRScanNotFoundViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirmButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;

@end
