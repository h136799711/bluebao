////
////  ContactOurVC.m
////  bluebao
////
////  Created by boye_mac1 on 15/7/16.
////  Copyright (c) 2015年 Boye. All rights reserved.
////
//
//#import "ContactOurVC.h"
//
//@interface ContactOurVC (){
//    
//    NSArray   *_dataArray;
//}
//@property (nonatomic,strong)UIWebView * webview;
//@end
//
//@implementation ContactOurVC
//
//-(UIWebView *)webview{
//    if(_webview == nil){
//        _webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    }
//    
//    return _webview;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
// 
//    _dataArray = @[@[@"企业电话",@"企业官网",@"微信公众账号"],@[@"464443",@"64267+7",@"55579671"]];
//    
//    [self _initViews];
//}
//
////初始化
//-(void)_initViews{
//    NSURL * url = [[NSURL alloc]initWithString: @"http://lanbao.app.itboye.com/contact.html"];
//    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:url];
//    self.webview.delegate = self;
//    [self.webview loadRequest:req];
//    [self.view addSubview:self.webview];
//    [self _initNavs];
//    
////    [self _initTableView];
//}
//
//-(void)_initTableView{
//    
//    self.tableView_our = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44*3)];
//    self.tableView_our.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView_our.delegate = self;
//    self.tableView_our.dataSource = self;
//    //    self.tableView.rowHeight = LEFT_MENU_HEIGHT;
//    [self.view addSubview:self.tableView_our];
//    
//}
//
//#pragma mark webview的委托
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//    if (error != nil) {
//      
//        [SVProgressHUD showErrorWithStatus:error.description withDuration:3];
//        
//    }else{
//        
//        [SVProgressHUD dismiss];
//    }
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [SVProgressHUD showProgress:100 status:@"加载中..."];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [SVProgressHUD dismiss];
//    
//}
//
//
//#pragma mark -- UITableViewDelegate ---
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return [_dataArray[0] count];
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static  NSString * identifier = @"cell";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
////        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
//    line.alpha = indexPath.row == [_dataArray[0] count ]-1?0:0.4;
//    
//    
//    cell.textLabel.font = FONT(15);
//    cell.textLabel.textColor = [UIColor lightGrayColor];
//    cell.textLabel.text = _dataArray[0][indexPath.row];
//    cell.detailTextLabel.font = FONT(15);
//    cell.detailTextLabel.text =  _dataArray[1][indexPath.row];
//    return cell;
//}
//
//#pragma mark -- 导航条 返回 --
//
//-(void)_initNavs{
//    
//    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.tag = 1;
//    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = letfItem;
//}
//
//
//
//#pragma mark --返回 --
//-(void)backClick{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
