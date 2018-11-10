//
//  YXCustomLabelViewController.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/7/31.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXCustomLabelViewController.h"
#import "YXLabel.h"

@interface YXCustomLabelViewController ()

@property (nonatomic, strong) YXLabel *label;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation YXCustomLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[YXLabel alloc] init];
    _label.backgroundColor = [UIColor cyanColor];
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"打开"];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, attributedString1.length)];
    
    [_label yxAddAttributedString:attributedString1 option:^(NSAttributedString *attributedString) {
        _infoLabel.text = @"打开";
    }];
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@"电扇"];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributedString2.length)];
    
    [_label yxAddAttributedString:attributedString2 option:^(NSAttributedString *attributedString) {
        _infoLabel.text = @"电扇";
    }];
    
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:@"哈哈"];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, attributedString3.length)];
    
    [_label yxAddAttributedString:attributedString3 option:^(NSAttributedString *attributedString) {
        _infoLabel.text = @"哈哈";
    }];
    
    
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


@end
