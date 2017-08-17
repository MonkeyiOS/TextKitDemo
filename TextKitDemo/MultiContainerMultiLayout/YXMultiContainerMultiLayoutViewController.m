//
//  YXMultiContainerMultiLayoutViewController.m
//  TextKitDemo
//
//  Created by 杨雄 on 2017/8/5.
//  Copyright © 2017年 yxiong.cn. All rights reserved.
//

#import "YXMultiContainerMultiLayoutViewController.h"

@interface YXMultiContainerMultiLayoutViewController ()<NSLayoutManagerDelegate>

@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManagerA;
@property (nonatomic, strong) NSLayoutManager *layoutManagerB;
@property (nonatomic, strong) UITextView *textViewA;
@property (nonatomic, strong) UITextView *textViewB;
@property (nonatomic, strong) NSTextContainer *textContainerA;
@property (nonatomic, strong) NSTextContainer *textContainerB;

@end

@implementation YXMultiContainerMultiLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;

    _textContainerA = [[NSTextContainer alloc] init];
    _textContainerB = [[NSTextContainer alloc] init];
    _layoutManagerA  = [[NSLayoutManager alloc] init];
    _layoutManagerB  = [[NSLayoutManager alloc] init];
    _textStorage    = [[NSTextStorage alloc] init];
    
    [_layoutManagerA addTextContainer:_textContainerA];
    [_layoutManagerB addTextContainer:_textContainerB];
    [_textStorage addLayoutManager:_layoutManagerA];
    [_textStorage addLayoutManager:_layoutManagerB];

    _textViewA = [[UITextView alloc] initWithFrame:CGRectZero textContainer:_textContainerA];
    _textViewA.backgroundColor = [UIColor lightGrayColor];
    _textViewB = [[UITextView alloc] initWithFrame:CGRectZero textContainer:_textContainerB];
    _textViewB.backgroundColor = [UIColor lightGrayColor];
    
    _layoutManagerB.delegate = self;
    
    [self.view addSubview:_textViewA];
    [self.view addSubview:_textViewB];
    
    NSString *testString = @"《天龙八部》是著名作家金庸的武侠代表作。著于1963年，历时4年创作完成（部分内容曾由倪匡代笔撰写），。http://google.com/aaaaaaaaaaaaa/bbdsfsdf 前后共有三版，并在2005年第三版中经历6稿修订，结局改动较大。\n小说以宋哲宗时代为背景，通过宋、辽、大理、西夏、吐蕃等王国之间的武林恩怨和民族矛盾，从哲学的高度对人生和社会进行审视和描写，展示了一幅波澜壮阔的生活画卷，其故事之离奇曲折、涉及人物之众多、历史背景之广泛、武侠战役之庞大、想象力之丰富当属“金书”之最。\n“天龙八部”出于佛经，有“世间众生”的意思，寓意象征着大千世界的芸芸众生，背后笼罩着佛法的无边与超脱。全书主旨“无人不冤，有情皆孽”，作品风格宏伟悲壮，是一部写尽人性、悲剧色彩浓厚的史诗巨著。\n《天龙八部》曾多次被改编成电影、电视剧、漫画及游戏。小说的第四十一回“燕云十八飞骑，奔腾如虎风烟举”于2005年入选到人民教育出版社出版的全日制普通高级中学语文读本（必修）中。《天龙八部》是著名作家金庸的武侠代表作。著于1963年，历时4年创作完成（部分内容曾由倪匡代笔撰写），前后共有三版，并在2005年第三版中经历6稿修订，结局改动较大。\n小说以宋哲宗时代为背景，通过宋、辽、大理、西夏、吐蕃等王国之间的武林恩怨和民族矛盾，从哲学的高度对人生和社会进行审视和描写，展示了一幅波澜壮阔的生活画卷，其故事之离奇曲折、涉及人物之众多、历史背景之广泛、武侠战役之庞大、想象力之丰富当属“金书”之最。\n“天龙八部”出于佛经，有“世间众生”的意思，寓意象征着大千世界的芸芸众生，背后笼罩着佛法的无边与超脱。全书主旨“无人不冤，有情皆孽”，作品风格宏伟悲壮，是一部写尽人性、悲剧色彩浓厚的史诗巨著。\n《天龙八部》曾多次被改编成电影、电视剧、漫画及游戏。小说的第四十一回“燕云十八飞骑，奔腾如虎风烟举”于2005年入选到人民教育出版社出版的全日制普通高级中学语文读本（必修）中。";
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:testString];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat textViewA_X = 10.0f;
    CGFloat textViewA_Y = 10.0f;
    CGFloat textViewA_W = self.view.bounds.size.width - textViewA_X * 2;
    CGFloat textViewA_H = 170.0f;
    CGRect textViewAFrame = CGRectMake(textViewA_X, textViewA_Y, textViewA_W, textViewA_H);
    _textViewA.frame = textViewAFrame;
    
    CGFloat textViewB_X = 10.f;
    CGFloat textViewB_Y = CGRectGetMaxY(textViewAFrame) + 10.0f;
    CGFloat textViewB_W = textViewA_W;
    CGFloat textViewB_H = textViewA_H;
    CGRect textViewBFrame = CGRectMake(textViewB_X, textViewB_Y, textViewB_W, textViewB_H);
    _textViewB.frame = textViewBFrame;
}

#pragma mark - NSLayoutManagerDelegate

- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex {
    NSDataDetector *linkDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    
    NSRange paragaphRange = [self.textStorage.string paragraphRangeForRange:NSMakeRange(charIndex, 1)];

    NSArray<NSTextCheckingResult *> *results = [linkDetector matchesInString:self.textStorage.string options:NSMatchingReportProgress range:paragaphRange];

    for (NSTextCheckingResult *result in results) {
        if (charIndex > result.range.location && charIndex <= NSMaxRange(result.range)) {
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    //行距
    return 10.f;
}

@end
