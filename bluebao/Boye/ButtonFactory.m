//
//  ButtonFactory.m
//  AFNTest
//
//  Created by hebidu on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "ButtonFactory.h"

@implementation ButtonFactory


+(UIButton *) decorateButton:(UIButton *)btn forType:(ENUM_BOYE_BUTTON_TYPE ) type{
    
    UIColor * bgColor;
    UIColor * titleColor;
    UIColor * bgForHighlightedColor;
    UIColor * titleForHighlightedColor;
    UIColor * bgForDisabledColor;
    UIColor * titleForDisabledColor;
    
    
    switch (type) {
        case BOYE_BTN_PRIMARY:
        {
            titleColor = [UIColor whiteColor];
            bgColor =  [UIColor colorWithRed:(14/255.0) green:(144/255.0) blue:(210/255.0) alpha:1];
            
            
            titleForHighlightedColor = [UIColor whiteColor];
            bgForHighlightedColor =  [UIColor colorWithRed:(12/255.0) green:(121/255.0) blue:(177/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
            bgForDisabledColor =  [UIColor colorWithRed:(14/255.0) green:(144/255.0) blue:(210/255.0) alpha:0.45];

        }break;
            
        case BOYE_BTN_SECONDARY:
        {
            titleColor = [UIColor whiteColor];
            bgColor =  [UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:1];
            
            
            titleForHighlightedColor = [UIColor whiteColor];
            bgForHighlightedColor =  [UIColor colorWithRed:(25/255.0) green:(167/255.0) blue:(240/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
            bgForDisabledColor =   [UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(242/255.0) alpha:0.45];
            
        }break;
            
        case BOYE_BTN_DANGER:
        {
            titleColor = [UIColor whiteColor];
            bgColor =  [UIColor colorWithRed:(221/255.0) green:(81/255.0) blue:(76/255.0) alpha:1];
            
            titleForHighlightedColor = [UIColor whiteColor];
            bgForHighlightedColor =  [UIColor colorWithRed:(215/255.0) green:(52/255.0) blue:(46/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
            bgForDisabledColor =   [UIColor colorWithRed:(221/255.0) green:(81/255.0) blue:(76/255.0) alpha:0.45];
            
        }break;
        case BOYE_BTN_SUCCESS:
        {
            titleColor = [UIColor whiteColor];
            bgColor =  [UIColor colorWithRed:(94/255.0) green:(185/255.0) blue:(94/255.0) alpha:1];
            
            titleForHighlightedColor = [UIColor whiteColor];
            bgForHighlightedColor =  [UIColor colorWithRed:(74/255.0) green:(170/255.0) blue:(74/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
            bgForDisabledColor =  [UIColor colorWithRed:(94/255.0) green:(185/255.0) blue:(94/255.0) alpha:0.45];
            
        }break;
        case BOYE_BTN_WARNING:{
            
            titleColor = [UIColor whiteColor];
            bgColor =  [UIColor colorWithRed:(243/255.0) green:(123/255.0) blue:(29/255.0) alpha:1];
            
            titleForHighlightedColor = [UIColor whiteColor];
            bgForHighlightedColor =  [UIColor colorWithRed:(224/255.0) green:(105/255.0) blue:(12/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
            bgForDisabledColor =   [UIColor colorWithRed:(243/255.0) green:(123/255.0) blue:(29/255.0) alpha:0.45];
            
        }break;
        case BOYE_BTN_DEFAULT:
        default:
        {
            titleColor =  [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:1];
            bgColor =  [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
            
            titleForHighlightedColor = titleColor;
            bgForHighlightedColor =  [UIColor colorWithRed:(212/255.0) green:(212/255.0) blue:(212/255.0) alpha:1];
            
            titleForDisabledColor =  [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:0.45];
            bgForDisabledColor =  [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:0.45];
            
        }break;
    }
    
    NSLog(@"bgcolor %@",bgColor);
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    
    [btn setTitleColor:titleForHighlightedColor forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[ButtonFactory imageWithColor:bgForHighlightedColor] forState:UIControlStateHighlighted];
//    [btn setBackgroundColor:bgForHighlightedColor];
    [btn setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [btn setTitleColor:titleForDisabledColor forState:UIControlStateDisabled];
//    [btn setBackgroundColor:bgForDisabledColor];

    [btn setBackgroundImage:[ButtonFactory imageWithColor:bgForDisabledColor] forState:UIControlStateDisabled];

    
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    [btn setContentEdgeInsets:edgeInset];
    
    return btn;
    
}

+(UIButton *)create:(ENUM_BOYE_BUTTON_TYPE ) type{
    
    UIButton * btn = [[UIButton alloc]init];
    
//    switch (type) {
//        case DEFAULT:
//            UIColor * color =  [[UIColor alloc]init];
//            
//            [btn setTitleColor:color forState:UIControlStateNormal];
//            break;
//        case PRIMARY:
//            UIColor * color =  [[UIColor alloc]init];
//            
//            [btn setTitleColor:color forState:UIControlStateNormal];
//            break;
//            
//        default:
//            break;
//    }
    
    return btn;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
