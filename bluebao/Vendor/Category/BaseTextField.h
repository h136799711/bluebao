//
//  BaseTextField.h


#import <UIKit/UIKit.h>

typedef enum
{
    TextFieldPadding_LEFT,
    TextFieldPadding_RIGHT,
    TextFieldPadding_ALL,
} TextFieldPadding;


@interface BaseTextField : UITextField

- (void)setPadding:(TextFieldPadding)_padding bounds:(CGRect)_paddingBounds;

- (void)setLeftBounds:(CGRect)_leftBounds rightBounds:(CGRect)_rightBounds;


@end
