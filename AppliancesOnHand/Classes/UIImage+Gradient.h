//
//  UIImage+Gradient.h
//  mam
//
//  Created by DEVTAB_006 on 12/7/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gradient)

+ (UIImage *)createGradientWithFrame: (CGRect )rect startColor: (UIColor *)startColor endColor: (UIColor *)endColor;
@end
