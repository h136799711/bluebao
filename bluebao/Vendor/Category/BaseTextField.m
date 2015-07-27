//
//  BaseTextField.m


#import "BaseTextField.h"

@interface BaseTextField()
{
    TextFieldPadding padding;
    CGRect           paddingBounds;
    CGRect           leftBounds;
    CGRect           rightBounds;
}
@end

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

#pragma mark -
#pragma mark 禁用TextField的拷贝、粘贴等菜单
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}


- (void)setPadding:(TextFieldPadding)_padding bounds:(CGRect)_paddingBounds
{
    padding = _padding;
    paddingBounds = _paddingBounds;
    
}

- (void)setLeftBounds:(CGRect)_leftBounds rightBounds:(CGRect)_rightBounds
{
    padding = TextFieldPadding_ALL;
    leftBounds = _leftBounds;
    rightBounds = _rightBounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    if (padding == TextFieldPadding_RIGHT)
    {
        return CGRectMake(bounds.origin.x + paddingBounds.origin.x * 2 + paddingBounds.size.width,
                          bounds.origin.y + paddingBounds.origin.y,
                          bounds.size.width - paddingBounds.size.width - self.rightView.bounds.size.width, bounds.size.height - paddingBounds.size.height);
    }
    else if(padding == TextFieldPadding_LEFT)
    {
        CGRect clearRect = [super clearButtonRectForBounds:bounds];
        return CGRectMake(bounds.origin.x + paddingBounds.origin.x * 2 + paddingBounds.size.width,
                          bounds.origin.y,
                          bounds.size.width - paddingBounds.size.width - paddingBounds.origin.x * 2 - clearRect.size.width, bounds.size.height );
    }
    else if(padding == TextFieldPadding_ALL)
    {
        CGRect clearRect = [super clearButtonRectForBounds:bounds];
        return CGRectMake(bounds.origin.x + leftBounds.origin.x * 2 + leftBounds.size.width,
                          bounds.origin.y,
                          bounds.size.width - leftBounds.size.width - leftBounds.origin.x * 2 - rightBounds.size.width - rightBounds.origin.x - clearRect.size.width, bounds.size.height );

    }
    else
    {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    if(padding == TextFieldPadding_LEFT)
    {
        return CGRectMake(bounds.origin.x + paddingBounds.origin.x, bounds.origin.y + paddingBounds.origin.y,
                         paddingBounds.size.width ,paddingBounds.size.height);
    }
    else if(padding == TextFieldPadding_ALL)
    {
        return CGRectMake(bounds.origin.x + leftBounds.origin.x, bounds.origin.y + leftBounds.origin.y,
                          leftBounds.size.width ,leftBounds.size.height);

    }
    return self.leftView.bounds;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    if (padding == TextFieldPadding_RIGHT)
    {
        return CGRectMake(bounds.origin.x - paddingBounds.origin.x - rightBounds.size.width, bounds.origin.y + paddingBounds.origin.y,
                          paddingBounds.size.width,paddingBounds.size.height);
    }
    else if(padding == TextFieldPadding_ALL)
    {
        return CGRectMake(bounds.size.width - rightBounds.origin.x - rightBounds.size.width, bounds.origin.y + rightBounds.origin.y,
                          rightBounds.size.width,rightBounds.size.height);

    }
    
    return self.rightView.bounds;
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    
    CGRect clearRect = [super clearButtonRectForBounds:bounds];
//    if (padding == TextFieldPadding_LEFT)
//    {
//        clearRect.size.width = bounds.size.width - paddingBounds.size.width - paddingBounds.origin.x * 2;
//    }
//    else if(padding == TextFieldPadding_ALL)
//    {
//        clearRect.size.width = bounds.size.width - leftBounds.size.width - leftBounds.origin.x * 2;
//    }
    
    return clearRect;
}


@end
