//
//  PersonMessageVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PersonMessageVC.h"

@interface PersonMessageVC (){
    
    
    NSArray   * sorArray;
    UIView    * _custemKeyView;  //自定义键盘
    
    UIView * _headView ;//个人头像个性签名视图
}

@property (nonatomic,strong) UITableView  * tableView_person;
@property (nonatomic,strong) UIPickerView * pickerview;
@end

@implementation PersonMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.navigationController.navigationBarHidden = NO;

    //创建视图
    [self _initViews];
    
}

/*
 *初始化视图
 **/

-(void)_initViews{
    sorArray = @[@"性别",@"出生日期",@"身高",@"当前体重",@"目标体重",@"BMI"];

    [self _initNavs];
    [self creatTableview];
    
    
    [self creatKeyBoard];
}

#pragma mark -- 返回 --

-(void)_initNavs{
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;

    
}
//创建表
-(void)creatTableview{
    
    if (self.tableView_person == nil) {
//        CGFloat   y = NAV_HEIGHT + STATUS_HEIGHT;
        CGFloat y = 0;
        self.tableView_person = [[UITableView alloc] initWithFrame:CGRectMake(0,y, SCREEN_WIDTH, SCREEN_HEIGHT-y ) style:UITableViewStyleGrouped];
        self.tableView_person.rowHeight = 44;
        self.tableView_person.delegate = self;
        self.tableView_person.dataSource = self;
        [self.view addSubview:self.tableView_person];
        //表头
        self.tableView_person.tableHeaderView = [self creatTableViewHeadView];
        //表尾
        self.tableView_person.tableFooterView = [self creatTableViewFootView];
    }
    
}

#pragma mark   TableViewDelegate  

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }else{
        
        return 4;
    }
    return sorArray.count;
}

//个人信息
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static    NSString * indentifier = @"cell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = sorArray[indexPath.row];

    }else{
        cell.textLabel.text = sorArray[indexPath.row+2];

    }
    cell.detailTextLabel.text = @"1";
    
    return cell;
    
}

//分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

//分区高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    
}
#pragma mark  修改信息  

-(void)changeResultClick:(UIButton *)resultbtn{
    
    
    
    
    
}


#pragma mark --创建表头--

-(UIView *)creatTableViewHeadView{
    
    if (_headView == nil) {
    
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _headView.backgroundColor = [UIColor clearColor];
        
        CGFloat  headWidth = 80;
        //头像
        UIButton * headBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.bounds = CGRectMake(0, 0, headWidth, headWidth);
        headBtn.center = CGPointMake(_headView.width/2.0, 40 + headWidth/2.0);
        [_headView addSubview:headBtn];
        [headBtn setTitle:@"头像" forState:UIControlStateNormal];
        headBtn.backgroundColor = [UIColor redColor];
        self.headImageBtn = headBtn;
        [headBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
        [MyTool cutViewConner:headBtn radius:headBtn.width/2.0];
        
        
        
        //编辑签名
        
        UITextField  * signTextfield = [[UITextField alloc] init];
        signTextfield.bounds = CGRectMake(0, 0, 80, 30);
        signTextfield.center = CGPointMake(headBtn.center.x, headBtn.bottom + signTextfield.height/2.0+3);
        signTextfield.textAlignment = NSTextAlignmentCenter;
        signTextfield. borderStyle  = UITextBorderStyleNone;
        signTextfield.font = FONT(16);
        signTextfield.text = @"张三";
        [_headView addSubview:signTextfield];
        self.personSignTextfield = signTextfield;
        
        //    签名
        UILabel * label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 160, 12);
        label.center = CGPointMake(signTextfield.center.x, signTextfield.bottom + label.height/2.0);
        label.text = @"请输入您的个性签名";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        [_headView addSubview:label];
        
    }
    
    
    
    return _headView;
}


#pragma mark --- 创建保存按钮 --

-(UIView *)creatTableViewFootView{

    UIView * footView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];

    //保存按钮
    UIButton * saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat  between = 40;
    saveBtn.frame = CGRectMake(between, 30, SCREEN_WIDTH - between *2, 30);
    [saveBtn setBackgroundColor:[UIColor blueColor]];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:saveBtn];

    return footView;
}

#pragma mark --- saveClick:
-(void)saveBtnClick{
    
    
    NSLog(@"保存");
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -- 自定义键盘 --
-(void)creatKeyBoard{
    
    if (_custemKeyView == nil) {
    
        //视图
        UIView * keyview = [[UIView alloc] init];
        keyview.backgroundColor = [UIColor lightGrayColor];
        keyview.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        keyview.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT + keyview.height/2.0 - STATUS_HEIGHT -NAV_HEIGHT);
        [self.view addSubview:keyview];

        //顶部黑条
        UIView * topView = [[UIView alloc] init];
        topView.frame = CGRectMake(0, 0, keyview.width, 30);
        topView.backgroundColor = [UIColor blackColor];
        [keyview addSubview:topView];
        
        //完成按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
  
        button.bounds = CGRectMake(0, 0, 40, 30);
        CGFloat  x  =  topView.width - 10 - button.bounds.size.width/2.0;
        button.center = CGPointMake(x, topView.height /2.0);
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topView addSubview:button];
//        [button addTarget:self action:@selector(overClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        #pragma mark -- PickView
        UIPickerView * pickerView = [[UIPickerView alloc] init];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.pickerview = pickerView;
        [keyview addSubview: pickerView];
        
        _custemKeyView = keyview;
    }
}

#pragma mark --- 从相册区图片--

-(void)uploadHeadImage{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张照",@"从相册中选", nil];
    [actionSheet showInView:self.view];

   
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        //如果相册功能不可用使用相册
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.tabBarItem.tag = 0;
        
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        //进入照相界面
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if(buttonIndex == 1) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            DLog(@"照相不可用");
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.tabBarItem.tag = 1;
        
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        ;//进入照相界面
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
    
}


#pragma mark  ---   图片选择器    ---

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    if (picker.tabBarItem.tag == 0)
    {
        //        //如果是 来自照相机的image，那么先保存
        //        UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //        UIImageWriteToSavedPhotosAlbum(original_image, self,
        //                                       @selector(image:didFinishSavingWithError:contextInfo:),
        //                                      nil);
    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
        [self.headImageBtn setImage:image forState:UIControlStateNormal];
        ;
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark --- pickView --

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return 1;
    }
    return 100;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return @"pic";
    }else{
        
        return [NSString stringWithFormat:@"%ld",(long)row];
    }
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"xxx");
}


#pragma mark --返回 --
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
