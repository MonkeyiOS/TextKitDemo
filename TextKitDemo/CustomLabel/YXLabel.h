//
//  YXLabel.h
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/17.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YXStringOption)(NSAttributedString *attributedString);

@interface YXLabel : UILabel

/**
 添加一个NSAttributedString，并关联事件

 @param attributedString 属性字符串
 @param option 事件
 */
- (void)yxAddAttributedString:(NSAttributedString *)attributedString option:(YXStringOption)option;

@end
