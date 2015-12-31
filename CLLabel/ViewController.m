//
//  ViewController.m
//  CLLabel
//
//  Created by chenguangjiang on 15/12/31.
//  Copyright © 2015年 dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "CLLabel.h"
@interface ViewController ()
{
    CLLabel *label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    label = [[CLLabel alloc]initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width - 20, self.view.bounds.size.height - 40)];
    label.backgroundColor = [UIColor brownColor];
    [self.view addSubview:label];
    label.text = @"第一版暂时集成了NSAttributring和UIlabel常用的一些属性:字体属性、字体颜色、对齐方式、截断方式、字间距、行间距、段间距,支持居上、居中、居下对齐,简单易用。\n另提供了一个算高的接口，如果用在cell上需要提前缓存算高的话需要先实例化一个label.....这也是没办法的事，UITableViewCell自动算高也是这么搞滴\n后续版本中会扩展更多的属性及功能";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    //label.textAlignment = NSTextAlignmentCenter;
    label.characterSpacing = 2.0;
    label.lineSpaceing = 5.0;
    label.paragraphSpacing = 10.0;
    label.headIndent = 30;
    label.firstLineHeadIndent = 60;
    label.textVerticalAlignment = NSTextVerticalAlignmentTop;
    
    
    
    label.strokeWidth = 2;
    label.strokeColor = [UIColor blueColor];
    label.strokeRanges = @[[NSValue valueWithRange:[label.text rangeOfString:@"NSAttributring"]]];
    label.showUnderline = YES;
    label.undelineStyle = NSUnderlineStyleThick;
    label.underlineColor = [UIColor blackColor];
    label.underlineRanges = @[[NSValue valueWithRange:[label.text rangeOfString:@"字间距、行间距、段间距,支持居上、居中、居下对齐"]]];
    CGSize size = [label getHeightConstrainedToSize:CGSizeMake(self.view.bounds.size.width - 20, self.view.bounds.size.height)];
     //[label getAttributedStringHeightWidthValue:self.view.bounds.size.height - 20];
    [label setFrame:CGRectMake(10, 20, size.width, size.height)];
    
    
    CLLabel * label1 = [[CLLabel alloc]init];
    label1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:label1];
    label1.text = @"根据约束得出宽度";
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = [UIColor whiteColor];
    label1.characterSpacing = 3.0;
    CGSize size1 = [label1 getHeightConstrainedToSize:CGSizeMake(self.view.bounds.size.width - 20, 100)];
    [label1 setFrame:CGRectMake(10, self.view.bounds.size.height - 40, size1.width, size1.height)];
    

    
    
}

@end
