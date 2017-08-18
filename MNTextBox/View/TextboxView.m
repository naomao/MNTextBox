//
//  TextboxView.m
//  TextboxDemo
//
//  Created by 毛闹 on 2017/8/10.
//  Copyright © 2017年 毛闹. All rights reserved.
//

#import "TextboxView.h"

@interface TextboxView()<UITextViewDelegate>

@property(strong, nonatomic) UILabel * titleLbl;
/**
 退出按钮
 */
@property(strong, nonatomic) UIButton * exitBtn;

/**
 提交按钮
 */
@property(strong, nonatomic) UIButton * submitBtn;

/**
 底层baseView
 */
@property(strong, nonatomic) UIView * baseView;
@end

@implementation TextboxView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.38];
        [self addConstraint];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        if (touch.view == self) {
             [self.delegate closeTextboxWindowDelegate];
        }
    }
}

#pragma mark - notification
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    float duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.baseView.centerY = KHEIGHT - (height + 225/2 + 30);
    }];
}
#pragma mark - event response
- (void)closeTextboxView{
    [self.delegate closeTextboxWindowDelegate];
}
- (void)submitRefuseInfo{
    [self.delegate submitRefuseInfoDelegate:self.textView.text];
}
#pragma mark - setters
- (void)setBoxTitle:(NSString *)boxTitle{
    _boxTitle = boxTitle;
    self.titleLbl.text = boxTitle;
}
- (void)setBoxPlaceHolder:(NSString *)boxPlaceHolder{
    _boxPlaceHolder = boxPlaceHolder;
    self.textView.placeholder = boxPlaceHolder;
    self.textView.placeholderColor = CellDetailColor;
    
}
#pragma mark - private method
- (void)addConstraint{
    self.baseView.sd_layout
    .leftSpaceToView(self, 15)
    .centerYIs(KHEIGHT/2)
    .rightSpaceToView(self, 15)
    .heightIs(225);
    self.baseView.sd_cornerRadius = @4;
    
    self.titleLbl.sd_layout
    .leftSpaceToView(self.baseView, 15)
    .topSpaceToView(self.baseView, 15)
    .widthIs(300)
    .heightIs(20);
    
    self.exitBtn.sd_layout
    .rightSpaceToView(self.baseView, 15)
    .topSpaceToView(self.baseView, 15)
    .heightIs(20)
    .widthIs(20);
    
    self.textView.sd_layout
    .leftSpaceToView(self.baseView, 15)
    .topSpaceToView(self.titleLbl, 15)
    .heightIs(125)
    .widthIs(KWIDTH - 60);
    
    self.submitBtn.sd_layout
    .centerXIs(KWIDTH/2)
    .topSpaceToView(self.textView, 15)
    .widthIs(85)
    .heightIs(25);
    self.submitBtn.sd_cornerRadius = @2;
}
#pragma mark - getters
- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textColor = CellTitleColor;
        [self.baseView addSubview:_titleLbl];
    }
    return _titleLbl;
}
- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}
- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc]init];
        [_exitBtn  setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(closeTextboxView) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:_exitBtn];
    }
    return _exitBtn;
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[MaoTextView alloc]init];
        _textView.layer.borderColor = CellDetailColor.CGColor;
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.layer.borderWidth = SEPARATOR_LINE_HEIGHT;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        [self.baseView addSubview:_textView];
    }
    return _textView;
}
- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _submitBtn.backgroundColor = PRIMARY_COLOR;
        [_submitBtn addTarget:self action:@selector(submitRefuseInfo) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:_submitBtn];
    }
    return _submitBtn;
}
@end
