//
//  ViewController.m
//  MNTextBoxView
//
//  Created by MacBook on 2017/8/17.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "ViewController.h"
#import "TextboxView.h"
@interface ViewController ()<TextboxDelegate>
@property(strong, nonatomic) UIView * bottomView;
@property(strong, nonatomic) UIButton * dealBtn;

//pop view
@property(strong, nonatomic) TextboxView * textboxView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBottomView];
}
- (void)addBottomView{
    //Top line
    UILabel * topLine = [[UILabel alloc]init];
    topLine.backgroundColor = SEPARATOR_LINE_COLOR;
    [self.bottomView addSubview:topLine];
    
    topLine.sd_layout
    .leftSpaceToView(self.bottomView, 0)
    .topSpaceToView(self.bottomView, 0)
    .rightSpaceToView(self.bottomView, 0)
    .heightIs(SEPARATOR_LINE_HEIGHT);
    
    self.dealBtn.sd_layout
    .leftSpaceToView(self.bottomView, 15)
    .topSpaceToView(self.bottomView, 15)
    .bottomSpaceToView(self.bottomView, 15)
    .rightSpaceToView(self.bottomView, 15);
    self.dealBtn.sd_cornerRadius = @4;
    
}



#pragma mark - TextboxDelegate
- (void)closeTextboxWindowDelegate
{
    [self.textboxView removeFromSuperview];
    self.textboxView = nil;
}
- (void)submitRefuseInfoDelegate:(NSString *)textInfo{
    
    NSLog(@"文本框输入内容：%@",textInfo);
    [self.textboxView removeFromSuperview];
    self.textboxView = nil;
}

#pragma mark - event response
- (void)dealThisApply{
    self.textboxView.hidden = NO;
    [self performSelector:@selector(becomeFirst) withObject:nil afterDelay:0.2];
}
- (void)becomeFirst{
    [self.textboxView.textView becomeFirstResponder];
}

#pragma mark - getters
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT - 74, KWIDTH, 74)];
        _bottomView.backgroundColor = BG;
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}
- (UIButton *)dealBtn{
    if (!_dealBtn) {
        _dealBtn = [[UIButton alloc]init];
        _dealBtn.backgroundColor = PRIMARY_COLOR;
        [_dealBtn setTitle:@"处 理" forState:UIControlStateNormal];
        _dealBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_dealBtn addTarget:self action:@selector(dealThisApply) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_dealBtn];
    }
    return _dealBtn;
}
- (TextboxView *)textboxView{
    if (!_textboxView) {
        _textboxView = [[TextboxView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _textboxView.boxTitle = @"处理信息";
        _textboxView.boxPlaceHolder = @"请输入处理信息(3~150字)";
        _textboxView.hidden = YES;
        _textboxView.delegate = self;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        [window addSubview:_textboxView];
    }
    return _textboxView;
}


@end
