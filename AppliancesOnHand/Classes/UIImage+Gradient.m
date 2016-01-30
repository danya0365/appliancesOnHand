//
//  UIImage+Gradient.m
//  mam
//
//  Created by DEVTAB_006 on 12/7/2558 BE.
//  Copyright © 2558 DEVTAB_006. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

+ (UIImage *)createGradientWithFrame: (CGRect )rect startColor: (UIColor *)startColor endColor: (UIColor *)endColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    
    gradientLayer.colors = @[ (__bridge id)startColor.CGColor,
                              (__bridge id)endColor.CGColor ];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext(gradientLayer.frame.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return gradientImage;
}

@end
