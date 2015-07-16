//
//  UIPlaceholderTextView.h
//  BlindDate
//
//  Created by apple on 14-9-26.
//
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知
@end
