//
//  YXLabel.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/17.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXLabel.h"

@interface YXLabel ()

@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;

@end

@implementation YXLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupTextSystem];
    }
    return self;
}

- (void)setupTextSystem {
    _textStorage = [[NSTextStorage alloc] init];
    _layoutManager = [[NSLayoutManager alloc] init];
    _textContainer = [[NSTextContainer alloc] init];
    
    [_textStorage addLayoutManager:_layoutManager];
    [_layoutManager addTextContainer:_textContainer];
    
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"我是一个可点击的label"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textContainer.size = self.bounds.size;
}

- (void)drawTextInRect:(CGRect)rect {
    NSRange range = NSMakeRange(0, self.textStorage.length);
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:CGPointMake(0, 0)];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:CGPointMake(0, 0)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    //根据点来获取该位置 glyph 的 index
    NSUInteger glyphIndex = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    //获取改 glyph 对应的 rect
    CGRect glyphRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:self.textContainer];
    //最终判断该字形的显示范围是否包括点击的 location
    if (CGRectContainsPoint(glyphRect, point)) {
        NSUInteger characterIndex = [self.layoutManager characterIndexForGlyphAtIndex:glyphIndex];
        unichar character = [[self.textStorage string] characterAtIndex:characterIndex];
        if ([self.delegate respondsToSelector:@selector(yxLabel:didSelectedCharacter:)]) {
            [self.delegate yxLabel:self didSelectedCharacter:character];
        }
    } else {
        //点中了空白区域
        if ([self.delegate respondsToSelector:@selector(yxLabelDidSelectedBlankSpace:)]) {
            [self.delegate yxLabelDidSelectedBlankSpace:self];
        }
    }
}

@end
