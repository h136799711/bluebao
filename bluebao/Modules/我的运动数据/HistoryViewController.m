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
@property (nonatomic,strong) NSMutableDictionary * data;

@property(nonatomic,strong) NSArray * keys;

@end

@implementation HistoryViewController

-(void)viewDidLoad{
    
    self.navigationController.navigationBarHidden = NO;
    
    [self initView];
    
    [self showUUChart];
    
    [self reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}

#pragma mark 1.getter\setter

-(NSMutableDictionary *)data{
    if(self->_data == nil){
        self->_data = [[NSMutableDictionary alloc]init];
    }
    return self->_data;
}

#pragma mark 2.继承方法

#pragma mark 3.自定义方法



-(void)reloadData{
    
    [self initChart];
    [self.data removeAllObjects];
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    NSDate * date = [formatter dateFromString:_lblDate.text];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSUInteger day = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
    NSLog(@"day= %ld",day);
    //TODO:向服务器请求载入数据
    
    for (int i=1; i<=day; i++) {
        NSLog(@"i=%d",i);
        if(i%2 == 1){
            
            [self.data setValue:[NSNumber numberWithInt:arc4random()%120] forKey: [NSString stringWithFormat:@"%d",i] ];
        }
    }

    
    //=================================
    [_chart showInView:self.view];
//    [_chart layoutIfNeeded];
}

-(void)nextMonth:(id)sender{
    
//    NSLog(@"%@",sender);
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    NSDate * date = [formatter dateFromString:_lblDate.text];
    
    NSDateComponents *compt = [[NSDateComponents alloc] init];
    [compt setYear:0];
    [compt setMonth:1];
    [compt setDay:0];
    [compt setHour:0];
    [compt setMinute:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSLog(@"%@",calendar);
    NSDate *nextMonth = [calendar dateByAddingComponents:compt toDate:date options:0];
    
    
//    NSLog(@"%@",nextMonth);
    _lblDate.text = [formatter stringFromDate:nextMonth];
    [self reloadData];
}

-(void)prevMonth{
    
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    NSDate * date = [formatter dateFromString:_lblDate.text];
    
    NSDateComponents *compt = [[NSDateComponents alloc] init];
    [compt setMonth:-1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *prevMonth = [calendar dateByAddingComponents:compt toDate:date options:0];
    
    _lblDate.text = [formatter stringFromDate:prevMonth];
    
    [self reloadData];
    
}

-(void)initChart{
    if(_chart != nil){
        [_chart removeAll];
    }
    _chart = nil;
    _chart = [[UUChart alloc] initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 360)
                                            withSource:self
                                             withStyle:UUChartLineStyle];
    [self.view addSubview:_chart];
    
    _chart.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray * bindConstraint = [[NSMutableArray alloc]init];
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


/**
 *  初始化视图\布局
 */
-(void)initView{
//    UIScrollView * scrollVie
    _prevBtn = [[UIButton alloc]init];
    [_prevBtn setTitle:@"<" forState:UIControlStateNormal];
    _nextBtn = [[UIButton alloc]init];
    [_nextBtn setTitle:@">" forState:UIControlStateNormal];
    
    [_prevBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_prevBtn addTarget:self action:@selector(prevMonth) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn addTarget:self action:@selector(nextMonth:) forControlEvents:UIControlEventTouchUpInside];
    
//    [ButtonFactory decorateButton:_prevBtn forType:BOYE_BTN_DEFAULT];
//    [ButtonFactory decorateButton:_nextBtn forType:BOYE_BTN_SECONDARY];
    
    
    if(self.navigationItem != nil){
        
        [self _initNavs];

        self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        self.title = @"历史数据";
        
        self.navigationController.navigationBarHidden = NO;
//        self.navigationController.navigationItem.hidesBackButton = NO;
//        self.navigationItem.hidesBackButton = NO;
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//        backItem.title = @"返回";
//        self.navigationItem.backBarButtonItem = backItem;
//        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        
    }
    
    _lblDate = [[UILabel alloc]init];
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    _lblDate.text = [formatter stringFromDate:[NSDate date]];
    
    _prevBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:_chart];
    [self.view addSubview:_lblDate];
    [self.view addSubview:_prevBtn];
    [self.view addSubview:_nextBtn];
    
    [self initChart];
    
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
    
    
    [self.view addConstraints:bindConstraint];

    
}
#pragma mark --返回 --
-(void)_initNavs{
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;
}

//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    NSNumber *max = [NSNumber numberWithInteger:NSIntegerMin];
//    NSNumber *min = [NSNumber numberWithInteger:NSIntegerMax];
    
    NSArray * values = [self.data allValues];
    for (NSNumber * num in values) {
        
        if([num compare:max] == NSOrderedDescending){
            max = num;
        }
        
//        if([num compare:min] == NSOrderedAscending){
//            min = num;
//        }
        
    }
    
    //设置Y轴数值
    return CGRangeMake( [max floatValue]+10,0);
}


//设置X
-(NSArray *)UUChart_xLableArray:(UUChart *)chart{
    //TODO: 获取X轴数据
    NSMutableArray *xTitles = [[NSMutableArray alloc]init];
    NSArray *tmp = [self.data allKeys];
    for(NSNumber * number in    tmp){
        [xTitles addObject:number];
    }
    
    self.keys = nil;
    self.keys  = [xTitles sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id sel1,id sel2){
        
        NSNumber * selfNumber = (NSNumber*)sel1;
         NSNumber * number = (NSNumber*)sel2;
        
        if([selfNumber floatValue] > [number floatValue]){
            return NSOrderedDescending;
        }else if([selfNumber floatValue] < [number floatValue]){
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
        
    }];
    
    
    return  self.keys;
}

//设置Y
-(NSArray *)UUChart_yValueArray:(UUChart *)chart{
    //TODO: 获取Y轴数据
//    NS *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"42"];
    NSMutableArray * values = [[NSMutableArray alloc]init];
    
    for(id key in self.keys) {
        id object = [self.data objectForKey:key];
        NSLog(@"object=%@",object);
        if(object != nil){
            [values addObject:object];
        }
    }
    
    return @[values];
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return NO;
}


@end
