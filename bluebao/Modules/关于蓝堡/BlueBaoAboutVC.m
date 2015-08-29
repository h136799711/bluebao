//
//  BlueBaoAboutVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BlueBaoAboutVC.h"
#import "WebViewController.h"
//#import "ContactOurVC.h"
//#import "OpinionVC.h"

@interface BlueBaoAboutVC (){
    
    NSArray         * _dataArray;
}

@property (nonatomic,strong) UIWebView * webview;
@end



@implementation BlueBaoAboutVC

-(UIWebView *)webview{
    if(_webview == nil){
        _webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    return _webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于蓝堡";
    self.navigationController.navigationBarHidden = NO;
    [self _initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化
-(void)_initViews{
    
//    _dataArray = @[@"关于蓝堡",@"联系我们",@"意见反馈"];
    _dataArray = @[@"关于蓝堡",@"联系我们"];
    NSURL * url = [[NSURL alloc]initWithString: @"http://lanbao.app.itboye.com/contact.html"];
    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:url];
    self.webview.delegate = self;
    [self.webview loadRequest:req];
    [self.view addSubview:self.webview];
    
    
//    [self _initTableView];
}

-(void)backClick{
    if (self.webview.canGoBack) {
        [self.webview goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
        if (error != nil) {
    
            [SVProgressHUD showErrorWithStatus:error.description withDuration:3];
    
        }else{
    
            [SVProgressHUD dismiss];
        }
    }
    
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"页面加载中..."];
     
}
    
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVProgressHUD dismiss];
    
    [webView setHeight:SCREEN_HEIGHT - 66];
}
//
//-(void)_initTableView{
//    
//    self.tableView_lb = [[UITableView alloc] initWithFrame:self.view.bounds];
//    self.tableView_lb.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView_lb.delegate = self;
//    self.tableView_lb.dataSource = self;
//    //    self.tableView.rowHeight = LEFT_MENU_HEIGHT;
//    [self.view addSubview:self.tableView_lb];
//
//}
//
//
//#pragma mark -- UITableViewDelegate ---
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return _dataArray.count;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static  NSString * identifier = @"cell";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        
//        //线
//        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.height -1,tableView.width, 1)];
//        lineLabel.tag = 1008;
//        lineLabel.backgroundColor = [UIColor lightGrayColor];
//        [cell.contentView addSubview:lineLabel];
//    }
//    
//    //隐藏横线
//    UILabel * line = (UILabel *) [cell.contentView viewWithTag:1008];
//    line.alpha = indexPath.row == _dataArray.count-1?0:0.5;
//    
//
//    cell.textLabel.font = FONT(15);
//    cell.textLabel.text = _dataArray[indexPath.row];
//    return cell;
//}
//
//#pragma mark --- 选中后 --
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row == 0) {
//        
////        WebViewController  * web = [[WebViewController alloc] init];
////        web.urlString = @"http://lanbaozg.tmall.com/?spm=a1z10.1-b.1997427721.d4918089.sQVqQy";
////        web.title = @"联系我们";
////        [self.navigationController pushViewController:web animated:YES];
//        
//        NSString * string = @"http://lanbaozg.tmall.com/?spm=a1z10.1-b.1997427721.d4918089.sQVqQy";
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//
//    }else if (indexPath.row == 1){
//      
//        ContactOurVC * conOur = [[ContactOurVC alloc] init];
//        conOur.title = @"联系我们";
//        [self.navigationController pushViewController:conOur animated:YES];
//        
//        
//        
//    }else{
//        
//        OpinionVC * opn = [[OpinionVC alloc] init];
//        opn.title = @"意见反馈";
//        [self.navigationController pushViewController:opn animated:YES];
//        
//    }
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
