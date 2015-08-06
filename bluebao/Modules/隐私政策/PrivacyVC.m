//
//  PrivacyVC.m
//  bluebao
//
//  Created by hebidu on 15/8/6.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PrivacyVC.h"

@interface PrivacyVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollPanel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@end

@implementation PrivacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户须知";
    self.contentText.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.contentText.scrollsToTop = YES;
//    self.contentText.text
    [self _initNavs];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


-(void)_initNavs{
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)awakeFromNib{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
