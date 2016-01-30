//
//  UIView+RenderViewToImage.m
//  ThaiTVLive
//
//  Created by DEVTAB_006 on 3/9/57.
//  Copyright (c) พ.ศ. 2557 devtab. All rights reserved.
//

#import "UIView+RenderViewToImage.h"

@implementation UIView (RenderViewToImage)

- (UIImage *)imageByRenderingView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    //[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}


@end
