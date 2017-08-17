//
//  YXIrregularityTextContainer.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/7.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXIrregularityTextContainer.h"

@implementation YXIrregularityTextContainer

#pragma mark - override

- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(CGRect *)remainingRect {
    //原始的范围
    CGRect rect = [super lineFragmentRectForProposedRect:proposedRect
                                                 atIndex:characterIndex
                                        writingDirection:baseWritingDirection
                                           remainingRect:remainingRect];
    //当前显示区域
    CGSize size = [self size];
    //当前区域的内切圆半径
    CGFloat radius = fmin(size.width, size.height) * 0.5;
    //得到不同状态下当前行的宽度
    CGFloat width = 0.0;
    if (proposedRect.origin.y == 0.0) {
        //初始行的宽度
        width = 40.0;
    } else if (proposedRect.origin.y <= 2 * radius) {
        //接下来圆范围内的行宽度
        width = 2.0 * sqrt(powf(radius, 2.0) - powf(fabs(proposedRect.origin.y - radius), 2.0));
    } else {
        //圆范围外的宽度
        width = 100.0;
    }
    //最终该行的宽度
    CGRect circleRect = CGRectMake(radius - width / 2.0, proposedRect.origin.y, width, proposedRect.size.height);
    
    //返回一个和原始范围的交集，防止溢出。
    return CGRectIntersection(rect, circleRect);
}

@end
