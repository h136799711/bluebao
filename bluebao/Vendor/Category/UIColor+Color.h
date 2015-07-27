//
//  UIColor+color.h


#import <UIKit/UIKit.h>

@interface UIColor (Color)
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
@end
