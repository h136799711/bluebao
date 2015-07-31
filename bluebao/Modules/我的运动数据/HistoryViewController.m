//
//  HistoryViewController.m
//  bluebao
//
//  Created by hebidu on 15/7/31.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController()
{
    UUChart * _chart;
    UILabel * _lblDate;
    
    UIButton * _prevBtn;
    UIButton * _nextBtn;
    
}

//KEY为X轴 Value为Y轴数据
@property (nonatomic,strong) NSDictionary * data;

@end

@implementation HistoryViewController

-(void)viewDidLoad{
    
    self.navigationController.navigationBarHidden = NO;
    
    [self initView];
    
    [self showUUChart];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

#pragma mark 1.getter\setter

#pragma mark 2.继承方法

#pragma mark 3.自定义方法

/**
 *  初始化视图\布局
 */
-(void)initView{
//    UIScrollView * scrollVie
    _prevBtn = [[UIButton alloc]init];
    [_prevBtn setTitle:@"<" forState:UIControlStateNormal];
    _nextBtn = [[UIButton alloc]init];
    [_nextBtn setTitle:@">" forState:UIControlStateNormal];
    
    
    [ButtonFactory decorateButton:_prevBtn forType:BOYE_BTN_SECONDARY];
    [ButtonFactory decorateButton:_nextBtn forType:BOYE_BTN_SECONDARY];
    
    _chart = [[UUChart alloc] initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 360)
                                            withSource:self
                                             withStyle:UUChartLineStyle];
    
    if(self.navigationItem != nil){
        
        self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        self.title = @"历史数据";
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationItem.hidesBackButton = NO;
        self.navigationItem.hidesBackButton = NO;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
    }
    
    _lblDate = [[UILabel alloc]init];
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    _lblDate.text = [formatter stringFromDate:[NSDate date]];
    
    _prevBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _chart.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.textAlignment = NSTextAlignmentCenter;
    
    [_chart showInView:self.view];
    
    [self.view addSubview:_lblDate];
    [self.view addSubview:_prevBtn];
    [self.view addSubview:_nextBtn];
    
    
    NSMutableArray * bindConstraint = [[NSMutableArray alloc]initWithArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_lblDate(>=120)]"
                                                                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                                                                    metrics:nil
                                                                                                                      views:NSDictionaryOfVariableBindings(_lblDate,_prevBtn,_nextBtn)]];
    
    
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_prevBtn]"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_prevBtn)]];
    
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_nextBtn]-10-|"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_nextBtn)]];
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_prevBtn]-5-[_chart]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_prevBtn,_chart)]];
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_nextBtn]-5-[_chart]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_nextBtn,_chart)]];
    
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_prevBtn]-10-[_lblDate]-10-[_nextBtn]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_prevBtn,_lblDate,_nextBtn)]];
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblDate]-5-[_chart]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_lblDate,_chart)]];
    
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_chart]-0-|"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_chart)]];

    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_chart]-0-|"
                                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_chart)]];
    
    [self.view addConstraints:bindConstraint];

    
}


-(void)showUUChart{
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    
    formatter.dateFormat = @"yyyy年mm月";
    
    NSDate * date =  [formatter dateFromString:_lblDate.text];
    
    //TODO:请求
    NSTimeInterval  interval = [date timeIntervalSince1970];
    
    NSNumber * timestamp = [NSNumber numberWithDouble:interval];
    
    NSLog(@"%@",timestamp);
    
}


#pragma mark 4.实现其它类的委托\数据源


#pragma mark 4.1折线图代码
//折线图代码=======

//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    //设置Y轴数值
    return CGRangeMake(100, 0);
}

//设置X
-(NSArray *)UUChart_xLableArray:(UUChart *)chart{
    //TODO: 获取X轴数据
    NSMutableArray *xTitles = [NSMutableArray array];
    
    for (int i=1; i<=31; i++) {
        if(i%2==1){
            NSString * str = [NSString stringWithFormat:@"%d",i];
            [xTitles addObject:str];
        }
    }
    return xTitles;
}

//设置Y
-(NSArray *)UUChart_yValueArray:(UUChart *)chart{
    //TODO: 获取Y轴数据
    NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"42"];
    
    return @[ary4];
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}


@end
