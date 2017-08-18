//
//  TextboxView.h
//  TextboxDemo
//
//  Created by 毛闹 on 2017/8/10.
//  Copyright © 2017年 毛闹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaoTextView.h"
@class  TextboxDelegate;
@protocol TextboxDelegate <NSObject>

- (void)closeTextboxWindowDelegate;
- (void)submitRefuseInfoDelegate:(NSString *)textInfo;

@end

@interface TextboxView : UIView

/**
 文本框标题
 */
@property(copy, nonatomic) NSString * boxTitle;

/**
 文本框placeHolder
 */
@property(copy, nonatomic) NSString * boxPlaceHolder;

@property(strong, nonatomic) MaoTextView * textView;

@property(weak, nonatomic) id<TextboxDelegate> delegate;
@end
