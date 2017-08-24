//
//  YXLabel.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/17.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXLabel.h"

@interface YXLabel ()

@property (nonatomic, strong) NSMutableArray<NSAttributedString *> *subAttributedStrings;
@property (nonatomic, strong) NSMutableArray<NSValue *> *subAttributedStringRanges;
@property (nonatomic, strong) NSMutableArray<YXStringOption> *stringOptions;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;

@end

@implementation YXLabel

#pragma mark - setter 

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setupTextSystem];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setupTextSystem];
}

#pragma mark - override

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _subAttributedStrings       = [NSMutableArray array];
        _subAttributedStringRanges  = [NSMutableArray array];
        _stringOptions              = [NSMutableArray array];
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

#pragma mark - event response

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
        
        [self.subAttributedStringRanges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = obj.rangeValue;
            if (NSLocationInRange(characterIndex, range)) {
                YXStringOption option = self.stringOptions[idx];
                option(self.subAttributedStrings[idx]);
            }
        }];
        
    }
}

#pragma mark - public method

- (void)yxAddAttributedString:(NSAttributedString *)attributedString option:(void (^)(NSAttributedString *))option {
    [self.subAttributedStrings addObject:attributedString];
    
    NSRange range = NSMakeRange(self.textStorage.length, attributedString.length);
    [self.subAttributedStringRanges addObject:[NSValue valueWithRange:range]];
    
    [self.stringOptions addObject:option];
    
    [self.textStorage appendAttributedString:attributedString];
}

@end
