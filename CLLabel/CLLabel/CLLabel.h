//
//  CLLabel.h
//  CLLabel
//
//  Created by chenguangjiang on 15/12/31.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,NSTextVerticalAlignment){
    NSTextVerticalAlignmentTop,
    NSTextVerticalAlignmentCenter,
    NSTextVerticalAlignmentBottom
};
@interface CLLabel : UIView
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) UIFont  *font;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic)        NSTextAlignment    textAlignment;
@property (nonatomic)        NSLineBreakMode    lineBreakMode;
@property (nonatomic)        NSTextVerticalAlignment textVerticalAlignment;//纵向排列
@property (nonatomic,assign) CGFloat characterSpacing;    //字间距
@property (nonatomic,assign) CGFloat lineSpaceing;        //行间距
@property (nonatomic,assign) CGFloat paragraphSpacing;    //段间距
@property (nonatomic,assign) CGFloat firstLineHeadIndent; //首行缩进
@property (nonatomic,assign) CGFloat headIndent;          //段头缩进
@property (nonatomic,assign) CGFloat tailIndent;          //段尾缩进


//随便写写
@property (nonatomic,assign) CGFloat strokeWidth;         //笔线宽度
@property (nonatomic,strong) UIColor *strokeColor;        //笔线颜色
@property (nonatomic,copy)   NSArray *strokeRanges;       //笔线作用区间
@property (nonatomic,assign) BOOL    showUnderline;       //是否显示下划线
@property (nonatomic,strong) UIColor *underlineColor;     //下划线颜色
@property (nonatomic,assign) enum NSUnderlineStyle undelineStyle;   //下划线样式
@property (nonatomic,copy)   NSArray *underlineRanges;      //下划线作用区间

-(CGSize)getHeightConstrainedToSize:(CGSize)size;
@end
