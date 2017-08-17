//
//  YXHighlightViewController.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/7/31.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXHighlightViewController.h"
#import "YXHighlightTextStorage.h"

@interface YXHighlightViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) YXHighlightTextStorage *textStorage;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSLayoutManager *layoutManager;

@end

@implementation YXHighlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _textContainer = [[NSTextContainer alloc] init];
    _layoutManager = [[NSLayoutManager alloc] init];
    _textStorage = [[YXHighlightTextStorage alloc] init];
    
    [_textStorage addLayoutManager:_layoutManager];
    [_layoutManager addTextContainer:_textContainer];
    _textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:_textContainer];
    _textView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_textView];
    
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"星号引起来的字符都会被*高亮*，*hello world* 星号引起来的字符都会"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat textView_X = 10.0f;
    CGFloat textView_Y = 10.0f;
    CGFloat textView_W = self.view.bounds.size.width - textView_X * 2;
    CGFloat textView_H = 200.0f;
    CGRect textViewFrame = CGRectMake(textView_X, textView_Y, textView_W, textView_H);
    _textView.frame = textViewFrame;
}

@end
