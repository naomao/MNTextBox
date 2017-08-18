//
//  MaoTextView.h
//  YunJing
//
//  Created by MacBook on 2017/8/11.
//  Copyright © 2017年 reining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaoTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
