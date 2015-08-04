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
    
    UILabel * _lblEmptyTip;

    UIButton * _prevBtn;
    UIButton * _nextBtn;
    
}



//KEY为X轴 Value为Y轴数据
@property (nonatomic,strong) NSMutableDictionary * data;

@property(nonatomic,strong) NSArray * keys;

@property (nonatomic,strong) UserInfo                   * userInfo;

@property (nonatomic,strong) NSString                   * uuid;

@end

@implementation HistoryViewController

- (UserInfo *) userInfo{
    if(_userInfo == nil){
        _userInfo = [MainViewController sharedSliderController].userInfo;
    }
    _userInfo.uid = 2;
    return _userInfo;
}

-(NSString *)uuid{
    
    if(_uuid == nil){
        _uuid = [[CacheFacade sharedCache] get:@"UUID"];
        if(_uuid == nil){
            _uuid = @"";
        }
    }
    return @"uuid-uuid";
    //    return _uuid;
}

-(void)viewDidLoad{
    
    
    [self initView];
    
    [self showUUChart];
    
    [self reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
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



-(void)showEmpty{
    //TODO: 显示无数据
    [_chart removeAll];
    
    _chart.hidden = YES;
    _chart.opaque = NO;
    _chart = nil;
    _lblEmptyTip.hidden = NO;
    _lblEmptyTip.opaque = YES;
    
}

-(void)reloadData{
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    NSDate * date = [formatter dateFromString:_lblDate.text];
    BicyleReqModel * reqModel = [[BicyleReqModel alloc]init];
    
    [reqModel setTime:[date timeIntervalSince1970]];
    
    [reqModel setUid:self.userInfo.uid];
    [reqModel setUuid:self.uuid];
    
    [BoyeBicyleManager requestMonthlyBicyleData:reqModel :^(NSDictionary* data){
        
        id obj = [data objectForKey:@"data"];
        
        NSLog(@"请求返回的数据=%@,%d",obj,(int)[obj isKindOfClass:[NSArray class]]);
        
        if(![obj isKindOfClass:[NSArray class]]){
            [self showEmpty];
            
            return ;
        }
        
        [self initChart];
        [self.data removeAllObjects];
        _lblEmptyTip.hidden = YES;
        _lblEmptyTip.opaque = NO;

        NSArray * dataInfo = (NSArray *)obj;
        NSLog(@"请求dataInfo的数据=%@",dataInfo);
        
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSUInteger day = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
        
        NSLog(@"day= %ld",day);
        
        if(data.count == 0){
            NSLog(@"无数据!");
            return ;
        }
        
        
        
        //TODO:向服务器请求载入数据
     
            for (int i=1; i<=day; i++) {
                NSLog(@"i=%d",i);
                
//                if(i%2 == 1){
                    NSNumber *upload_day = [NSNumber numberWithInteger:0];
                    NSNumber *max_calorie = [NSNumber numberWithInteger:0];
                    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];

                    for (int j=0; j<dataInfo.count; j++) {
                        NSDictionary * dict = (NSDictionary*)dataInfo[j];
                        
                        upload_day =[ formatter numberFromString:(NSString*)[dict valueForKey:@"upload_day"] ];
                        NSLog(@"data=%ld",[upload_day integerValue]);
                        if(i == [upload_day integerValue]){
                            NSLog(@"upload_day=%@,calorie=%@",upload_day,max_calorie);
                            
                            max_calorie = [formatter numberFromString:(NSString *)[dict valueForKey:@"max_calorie"]];
                            
                            break;
                        }
                    }
                    
                    if(i == [upload_day integerValue]){
                        [self.data setValue:max_calorie forKey: [NSString stringWithFormat:@"%ld",  [upload_day integerValue]] ];
                    }else{
                        [self.data setValue:[NSNumber numberWithInteger:0] forKey: [NSString stringWithFormat:@"%d",  i] ];
                    }
                    
//                }
            }
        
        if(self.data.count == 0){
            [self showEmpty];
        }else{
            [_chart showInView:self.view];
        }
    } :nil ];
    
    
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
    
    NSDate *nextMonth = [calendar dateByAddingComponents:compt toDate:date options:0];
    
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
    _chart.hidden = NO;
    
    [self.view insertSubview:_chart belowSubview:_lblEmptyTip];
    
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
    
    if(self.navigationItem != nil){
        
        self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        self.title = @"历史数据";
        self.navigationController.navigationBarHidden = NO;
    }
    
    _lblDate = [[UILabel alloc]init];
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    formatter.dateFormat = @"yyyy年MM月";
    _lblDate.text = [formatter stringFromDate:[NSDate date]];
    
    _lblEmptyTip = [[UILabel alloc] init];
    
    _lblEmptyTip.text = @"没有相关数据!";
    _lblEmptyTip.textColor = [UIColor grayColor];
    _lblEmptyTip.translatesAutoresizingMaskIntoConstraints = NO;
    _lblEmptyTip.textAlignment = NSTextAlignmentCenter;
    _lblEmptyTip.hidden = YES;
    _prevBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDate.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_lblDate];
    [self.view addSubview:_prevBtn];
    [self.view addSubview:_nextBtn];
    [self.view addSubview:_lblEmptyTip];
    
    [self initChart];
    
    NSMutableArray * bindConstraint = [[NSMutableArray alloc]initWithArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_lblDate(>=120)]"
                                                                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                                                                    metrics:nil
                                                                                                                      views:NSDictionaryOfVariableBindings(_lblDate,_prevBtn,_nextBtn)]];
    
    
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lblEmptyTip(>=120)]|"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_lblEmptyTip)]];
    
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
    [bindConstraint  addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lblDate]-15-[_lblEmptyTip]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_lblEmptyTip,_lblDate)]];
    
    [self.view addConstraints:bindConstraint];
    
}

-(BOOL)isThisMonth{
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    
    formatter.dateFormat = @"yyyy年MM月";
    
    NSDate * date =  [formatter dateFromString:_lblDate.text];
    
    NSLog(@"date=%@",date);
    NSDate *now = [NSDate  date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowComponent = [calendar components:unitFlags fromDate:now];
    
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSLog(@"now=%@,date=%@",nowComponent,dateComponent);
    

    return  nowComponent.month == dateComponent.month;
}

-(void)showUUChart{
    
    NSDateFormatter * formatter = [NSDate defaultDateFormatter];
    
    formatter.dateFormat = @"yyyy年MM月";
    
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
    
    NSArray * values = [self.data allValues];
    for (NSNumber * num in values) {
        
        if([num compare:max] == NSOrderedDescending){
            max = num;
        }
        
    }
    
    
    if([max integerValue] == NSIntegerMin){
        return CGRangeMake( 1000,0);
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
    
    BOOL flag = [self isThisMonth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"%@",nowComponent);
    for(id key in self.keys) {
        id object = [self.data objectForKey:key];
//        NSLog(@"object=%@",object);
        if(object != nil){
            if(flag && nowComponent.day <= (values.count)){
                continue;
            }
//            NSNumber * num = (NSNumber *)object;
//            if([num floatValue]  > 0){
                [values addObject:object];
//            }
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
