//
//  YXCustomLabelViewController.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/7/31.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXCustomLabelViewController.h"
#import "YXLabel.h"

@interface YXCustomLabelViewController ()<YXLabelDelegate>

@property (nonatomic, strong) YXLabel *label;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation YXCustomLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[YXLabel alloc] init];
    _label.delegate = self;
    _label.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_label];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_infoLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _label.frame = CGRectMake(50, 100, self.view.bounds.size.width - 50 * 2, 40);
    
    _infoLabel.frame = CGRectMake(0, 400, self.view.bounds.size.width, 30);
}

#pragma mark - YXLabelDelegate

- (void)yxLabel:(YXLabel *)label didSelectedCharacter:(unichar)character {
    self.infoLabel.text = [NSString stringWithFormat:@"点击了：%C", character];
}

- (void)yxLabelDidSelectedBlankSpace:(YXLabel *)label {
    self.infoLabel.text = @"点中了空白区域";
}

@end
