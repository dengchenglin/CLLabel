//
//  CLLabel.m
//  CLLabel
//
//  Created by chenguangjiang on 15/12/31.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import "CLLabel.h"
#import <CoreText/CoreText.h>
@implementation CLLabel{
    NSMutableAttributedString *_attributedText;
}
-(instancetype)init{
    if(self = [super init]){
        _font = [UIFont systemFontOfSize:17];
        _textColor = [UIColor blackColor];
        _textVerticalAlignment = NSTextVerticalAlignmentTop;
        _showUnderline = NO;
        _undelineStyle = NSUnderlineStyleSingle;
        _underlineColor = [UIColor redColor];
        _strokeColor = [UIColor blackColor];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _font = [UIFont systemFontOfSize:17];
        _textColor = [UIColor blackColor];
        _textVerticalAlignment = NSTextVerticalAlignmentTop;
        _showUnderline = NO;
        _undelineStyle = NSUnderlineStyleSingle;
        _underlineColor = [UIColor redColor];
        _strokeColor = [UIColor blackColor];
    }
    return self;
}
-(void)setText:(NSString *)text{
    _text = text;
    _attributedText = [[NSMutableAttributedString alloc]initWithString:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    _font = font;
    [self setNeedsDisplay];
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setNeedsDisplay];
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    [self setNeedsDisplay];
}
-(void)setTextVerticalAlignment:(NSTextVerticalAlignment)textVerticalAlignment{
    _textVerticalAlignment = textVerticalAlignment;
    [self setNeedsDisplay];
}
-(void)setLineBreakMode:(NSLineBreakMode)lineBreakMode{
    _lineBreakMode = lineBreakMode;
    [self setNeedsDisplay];
}
-(void)setCharacterSpacing:(CGFloat)characterSpacing{
    _characterSpacing = characterSpacing;
    [self setNeedsDisplay];
}
-(void)setLineSpaceing:(CGFloat)lineSpaceing{
    _lineSpaceing = lineSpaceing;
    [self setNeedsDisplay];
}
-(void)setParagraphSpacing:(CGFloat)paragraphSpacing{
    _paragraphSpacing = paragraphSpacing;
    [self setNeedsDisplay];
}
-(void)setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent{
    _firstLineHeadIndent = firstLineHeadIndent;
    [self setNeedsDisplay];
}
-(void)setHeadIndent:(CGFloat)headIndent{
    _headIndent = headIndent;
    [self setNeedsDisplay];
}
-(void)setShowUnderline:(BOOL)showUnderline{
    _showUnderline = showUnderline;
    [self setNeedsDisplay];
}
-(void)setUndelineStyle:(enum NSUnderlineStyle)undelineStyle{
    _undelineStyle = undelineStyle;
    [self setNeedsDisplay];
}
-(void)setUnderlineColor:(UIColor *)underlineColor{
    _underlineColor = underlineColor;
    [self setNeedsDisplay];
}
-(void)setUnderlineRanges:(NSArray *)underlineRanges{
    _underlineRanges = underlineRanges;
    [self setNeedsDisplay];
}
-(void)setStrokeRanges:(NSArray *)strokeRanges{
    _strokeRanges = strokeRanges;
    [self setNeedsDisplay];
}
-(void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}
-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    if(!_attributedText)return;
    [self configurationAttributedText];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, [self getLayoutFrame]);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //告诉context需要进行矩阵转换
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    //y坐标先平移bounds.size.height
    CGContextTranslateCTM(context , 0 ,rect.size.height);
    //沿x抽翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(frame, context);
    CFRelease(path);
    CFRelease(frameSetter);
    CFRelease(frame);
}
- (void)configurationAttributedText{
    
    NSRange lengthRange = NSMakeRange(0, _attributedText.length);
    CTFontRef font = CTFontCreateWithName((CFStringRef)_font.fontName, _font.pointSize, NULL);
    
    //字体属性
    [_attributedText addAttribute:(__bridge id)kCTFontAttributeName value:(__bridge id)font range:lengthRange];
    CFRelease(font);
    
    //字体颜色
    [_attributedText addAttribute:(__bridge id)kCTForegroundColorAttributeName value:_textColor range:lengthRange];
    
    //字符间隔
    [_attributedText addAttribute:(__bridge id)kCTKernAttributeName value:[NSNumber numberWithFloat:_characterSpacing] range:lengthRange];
    
    //字体对齐方式
    CTTextAlignment alignment = kCTTextAlignmentLeft;
    if(_textAlignment == NSTextAlignmentCenter)alignment = kCTTextAlignmentCenter;
    if(_textAlignment == NSTextAlignmentRight) alignment = kCTTextAlignmentRight;
    if(_textAlignment == NSTextAlignmentJustified) alignment = kCTTextAlignmentJustified;
    if(_textAlignment == NSTextAlignmentNatural) alignment = kCTTextAlignmentNatural;
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    CGFloat lineSpace = _lineSpaceing;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacings = _paragraphSpacing;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacings;
    
    //每段首行缩进
    CGFloat firstLineHeadIndent = _firstLineHeadIndent;
    CTParagraphStyleSetting paragraphfirstlineHeadIndent;
    paragraphfirstlineHeadIndent.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    paragraphfirstlineHeadIndent.valueSize = sizeof(CGFloat);
    paragraphfirstlineHeadIndent.value = &firstLineHeadIndent;
    
    //段缩进(除首行)
    CGFloat headIndent = _headIndent;
    CTParagraphStyleSetting paragraphHeadIndent;
    paragraphHeadIndent.spec = kCTParagraphStyleSpecifierHeadIndent;
    paragraphHeadIndent.valueSize = sizeof(CGFloat);
    paragraphHeadIndent.value = &headIndent;

    //换行模式
    CTLineBreakMode linBreakMode = kCTLineBreakByWordWrapping;
    if(_lineBreakMode == NSLineBreakByCharWrapping)linBreakMode = kCTLineBreakByCharWrapping;
    if(_lineBreakMode == NSLineBreakByClipping)linBreakMode = kCTLineBreakByClipping;
    if(_lineBreakMode == NSLineBreakByTruncatingHead)linBreakMode = kCTLineBreakByTruncatingHead;
    if(_lineBreakMode == NSLineBreakByTruncatingTail)linBreakMode = kCTLineBreakByTruncatingTail;
    if(_lineBreakMode == NSLineBreakByTruncatingMiddle)linBreakMode = kCTLineBreakByTruncatingMiddle;
    CTParagraphStyleSetting lineBreakModeStye;
    lineBreakModeStye.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakModeStye.value = &linBreakMode;
    lineBreakModeStye.valueSize = sizeof(CTLineBreakMode);
    
    
    CTParagraphStyleSetting settings[] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle,paragraphfirstlineHeadIndent,paragraphHeadIndent,lineBreakModeStye};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,5);
    [_attributedText addAttribute:(__bridge id)kCTParagraphStyleAttributeName value:(__bridge id)style range:lengthRange];
    

    if(_strokeRanges){
        for(NSValue *rangeValue in _strokeRanges){
            //笔线宽度
            [_attributedText addAttribute:(__bridge id)kCTStrokeWidthAttributeName value:[NSNumber numberWithFloat:_strokeWidth] range:[rangeValue rangeValue]];
            //笔线颜色
            [_attributedText addAttribute:(__bridge id)kCTStrokeColorAttributeName value:_strokeColor range:[rangeValue rangeValue]];
        }
    }
    else{
        //笔线宽度
        [_attributedText addAttribute:(__bridge id)kCTStrokeWidthAttributeName value:[NSNumber numberWithFloat:_strokeWidth] range:lengthRange];
        //笔线颜色
        [_attributedText addAttribute:(__bridge id)kCTStrokeColorAttributeName value:_strokeColor range:lengthRange];
    }

    
    //下划线
    if(_showUnderline){
        if (_underlineRanges) {
            for(NSValue *rangeValue in _underlineRanges){
                [_attributedText removeAttribute:(__bridge id)kCTUnderlineColorAttributeName range:[rangeValue rangeValue]];
                 [_attributedText removeAttribute:(__bridge id)kCTUnderlineStyleAttributeName range:[rangeValue rangeValue]];
            }
            for(NSValue *rangeValue in _underlineRanges){
                [_attributedText addAttribute:(__bridge id)kCTUnderlineColorAttributeName value:_underlineColor range:[rangeValue rangeValue]];
                [_attributedText addAttribute:(__bridge id)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInteger:_undelineStyle] range:[rangeValue rangeValue]];
            }
        }
        else{
            [_attributedText addAttribute:(__bridge id)kCTUnderlineColorAttributeName value:_underlineColor range:lengthRange];
            [_attributedText addAttribute:(__bridge id)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInteger:_undelineStyle] range:lengthRange];
        }

    }
    else{
        if(_underlineRanges){
            for(NSValue *rangeValue in _underlineRanges){
                [_attributedText removeAttribute:(__bridge id)kCTUnderlineColorAttributeName range:[rangeValue rangeValue]];
                [_attributedText removeAttribute:(__bridge id)kCTUnderlineStyleAttributeName range:[rangeValue rangeValue]];
            }
        }
        else{
            [_attributedText removeAttribute:(__bridge id)kCTUnderlineColorAttributeName range:lengthRange];
            [_attributedText removeAttribute:(__bridge id)kCTUnderlineStyleAttributeName range:lengthRange];
        }
        
    }
}

-(CGFloat)getHeightforWidth:(CGFloat)width{
    if(!_attributedText)return 0;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedText);
    CGSize textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, CGSizeMake(width, CGFLOAT_MAX), nil);
    CFRelease(framesetter);
    return textSize.height;
}
-(CGRect)getLayoutFrame{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGFloat height = [self getHeightforWidth:self.bounds.size.width];
    if(_textVerticalAlignment == NSTextVerticalAlignmentCenter){
        return CGRectMake(0, (self.bounds.size.height - height)/2, self.bounds.size.width, height);
    }
    if (_textVerticalAlignment == NSTextVerticalAlignmentBottom){
        return CGRectMake(0,  0, self.bounds.size.width, height);
    }
    return rect;
}


@end
