//
//  YXHighlightTextStorage.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/3.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXHighlightTextStorage.h"

@implementation YXHighlightTextStorage {
    NSMutableAttributedString *_mutableAttributedString;
    NSRegularExpression *_expression;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mutableAttributedString = [[NSMutableAttributedString alloc] init];
        _expression = [NSRegularExpression regularExpressionWithPattern:@"(\\*\\w+(\\s*\\w+)*\\s*\\*)" options:0 error:NULL];
    }
    return self;
}

- (NSString *)string {
    return _mutableAttributedString.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [_mutableAttributedString attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [_mutableAttributedString replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [_mutableAttributedString setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

// Sends out -textStorage:willProcessEditing, fixes the attributes, sends out -textStorage:didProcessEditing, and notifies the layout managers of change with the -processEditingForTextStorage:edited:range:changeInLength:invalidatedRange: method.  Invoked from -edited:range:changeInLength: or -endEditing.
- (void)processEditing {
    [super processEditing];
    //去除当前段落的颜色属性
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    //根据正则匹配，添加新属性
    [_expression enumerateMatchesInString:self.string options:NSMatchingReportProgress range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
    }];
}

@end
