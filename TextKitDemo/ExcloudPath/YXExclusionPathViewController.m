//
//  YXExclusionPathViewController.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/5.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXExclusionPathViewController.h"

@interface YXExclusionPathViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) UIView *exclusionView;

@end

@implementation YXExclusionPathViewController {
    CGPoint _offSetFromCenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    _textContainer = [[NSTextContainer alloc] init];
    _layoutManager = [[NSLayoutManager alloc] init];
    _textStorage   = [[NSTextStorage alloc] init];
    
    [_textStorage addLayoutManager:_layoutManager];
    [_layoutManager addTextContainer:_textContainer];
    _textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:_textContainer];
    _textView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_textView];
    
    NSString *testString = @"q a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a";
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:testString];
    
    _exclusionView = [[UIView alloc] init];
    _exclusionView.backgroundColor = [UIColor redColor];
    [self.textView addSubview:_exclusionView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [_exclusionView addGestureRecognizer:pan];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat textView_X = 10.0f;
    CGFloat textView_Y = 10.0f;
    CGFloat textView_W = self.view.bounds.size.width - textView_X * 2;
    CGFloat textView_H = 300.0f;
    CGRect textViewFrame = CGRectMake(textView_X, textView_Y, textView_W, textView_H);
    _textView.frame = textViewFrame;

    CGFloat view_X = 140.0f;
    CGFloat view_Y = 40.0f;
    CGFloat view_W = 120.0f;
    CGFloat view_H = view_W;
    CGRect viewFrame = CGRectMake(view_X, view_Y, view_W, view_H);
    _exclusionView.frame = viewFrame;
    _exclusionView.layer.masksToBounds = YES;
    _exclusionView.layer.cornerRadius = view_W * 0.5;
    
    [self updateExclusionPath];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)updateExclusionPath {
    CGRect originalPathRect = self.exclusionView.frame;
    CGFloat circle_X = originalPathRect.origin.x - self.textView.textContainerInset.left;
    CGFloat circle_Y = originalPathRect.origin.y - self.textView.textContainerInset.top;
    CGFloat circle_W = originalPathRect.size.width;
    CGFloat circle_H = originalPathRect.size.height;
    CGRect circleRect = CGRectMake(circle_X, circle_Y, circle_W, circle_H);
    
    UIBezierPath *exclusionCirclePath = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    _textContainer.exclusionPaths = @[exclusionCirclePath];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        _offSetFromCenter = [pan locationInView:self.exclusionView];
    }
    CGPoint locationPointSuperView = [pan locationInView:self.textView];

    CGPoint circleCenter = self.exclusionView.center;
    CGFloat radius = self.exclusionView.bounds.size.width * 0.5;
    circleCenter.x = locationPointSuperView.x + (radius - _offSetFromCenter.x);
    circleCenter.y = locationPointSuperView.y + (radius - _offSetFromCenter.y);
    self.exclusionView.center = circleCenter;
    
    [self updateExclusionPath];
}
@end
