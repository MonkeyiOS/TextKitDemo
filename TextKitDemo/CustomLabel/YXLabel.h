//
//  YXLabel.h
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/17.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXLabel;

@protocol YXLabelDelegate <NSObject>

- (void)yxLabel:(YXLabel *)label didSelectedCharacter:(unichar)character;
- (void)yxLabelDidSelectedBlankSpace:(YXLabel *)label;

@end

@interface YXLabel : UILabel

@property (nonatomic, weak) id<YXLabelDelegate> delegate;


@end
