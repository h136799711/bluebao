//
//  PersonMessageVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/7.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PersonMessageVC.h"
#import "MessageCell.h"
#import "PickerKeyBoard.h"

@interface PersonMessageVC (){
    
    
    NSArray         * sorArray;
    UIView          * _custemKeyView;  //自定义键盘
    
    UIView          * _headView ;//个人头像个性签名视图
    
    UIView          * _sexheightView; //身高性别
    
    NSInteger         _currentRow;//当前行；
    
    
    
}

@end

@implementation PersonMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.navigationController.navigationBarHidden = NO;

    _currentRow = 0;
    sorArray = @[@"当前体重",@"目标体重",@"BMI"];
    self.valueArray = [[NSMutableArray alloc] initWithObjects:@"55KG",@"55KG",@"", nil];
    
    //创建视图
    [self _initViews];
    
}

/*
 *初始化视图
 **/

-(void)_initViews{
    
    //导航条
    [self _initNavs];
    //tableView
    [self _initTableview];
    //自定义键盘
    [self _initPickerKeyBoard];
    
}


#pragma mark ----创建表 ---
-(void)_initTableview{
    
    if (self.tableView_person == nil) {
        CGFloat   left = 20;
        CGFloat h = SCREEN_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT;
        self.tableView_person = [[UITableView alloc] initWithFrame:CGRectMake(left,0, SCREEN_WIDTH -left *2, h) style:UITableViewStyleGrouped];
        self.tableView_person.rowHeight = 44;
        self.tableView_person.delegate = self;
        self.tableView_person.dataSource = self;
        self.tableView_person.backgroundColor = [UIColor clearColor];
        self.tableView_person.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView_person];
        //表头
        self.tableView_person.tableHeaderView = [self creatTableViewHeadView];
        //表尾
        self.tableView_person.tableFooterView = [self creatTableViewFootView];

        [self refreshBMI];//刷新BMI
        
    }
    
}

#pragma mark ----  TableViewDelegate  ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return  sorArray.count;
}

#pragma mark -- tableViewDelegate ---
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static  NSString * ident = @"personCell";
    MessageCell * personCell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:ident];
    
    if (personCell == nil) {
        personCell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        personCell.contentView.width = tableView.width;

        }
    //清除子视图
    [MyTool clearCellSonView:personCell.contentView viewTag: 1008];
    
    if (indexPath.row  < sorArray.count -1) {
        //横线
        [MyTool createLineInView:personCell.contentView
                            fram:CGRectMake(4, personCell.contentView.height, tableView.width - 4*2, 1)];
    }
    // 创建背景视图
    [BBManageCode createdBackGroundView:personCell.contentView
                               indexRow:indexPath.row
                               maxCount:sorArray.count -1];

    //赋值
    personCell.tag = indexPath.row;
    personCell.label_sort.text = sorArray[indexPath.row];
    personCell.label_value.text = [self.valueArray objectAtIndex:indexPath.row];
    personCell.label_value.frame = CGRectMake(tableView.width/2.0, 0, tableView.width/2.0-30, tableView.rowHeight );
    return personCell;

}


#pragma mark --- 选中 cell--
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    //BMI一行不能点击
    if (indexPath.row == sorArray.count -1) {
        
        return;
    }
    
    
    _currentRow = indexPath.row;
    [tableView reloadData];
  
    //当前体重，
    self.pickerKeyBoard.minimumZoom = 25;
    self.pickerKeyBoard.maximumZoom = 150;
    self.pickerKeyBoard.currentmumZoom = [self getCurrentNum:self.valueArray[indexPath.row]];
    
    self.pickerKeyBoard.dataName = sorArray[indexPath.row];
    self.pickerKeyBoard.dataUnit = @"KG";
    self.pickerKeyBoard.tag = 0;
    [self.pickerKeyBoard.pickerView reloadAllComponents];
    [self.pickerKeyBoard open];
    
}
//分区高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

#pragma mark ---- 创建区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self createdHeaderInSection];
}

#pragma mark --- 性别 ---
-(void)sexBtnClick:(UIButton *)sexBtn{
    sexBtn.selected = !sexBtn.selected;
    
}

#pragma mark -- 身高 --
-(void)heightBtnClick:(UIButton *)heightBtn{
    //当前体重，
    self.pickerKeyBoard.minimumZoom = 50;
    self.pickerKeyBoard.maximumZoom = 250;
    self.pickerKeyBoard.currentmumZoom = [self getCurrentNum:self.heightButton.currentTitle ];
    self.pickerKeyBoard.dataName = @"身高";
    self.pickerKeyBoard.dataUnit = @"CM";
   
    self.pickerKeyBoard.tag = 10;

    [self.pickerKeyBoard.pickerView reloadAllComponents];
    [self.pickerKeyBoard open];
}


#pragma mark --创建表头--

-(UIView *)creatTableViewHeadView{
    
    if (_headView == nil) {
        //创建个人资料信息（头像签名等）
      
        self.headImageBtn  = [UIButton buttonWithType:UIButtonTypeCustom];

        _headView = [BBManageCode  createdPersonInfoShowInView:_headView
                                                       headBtn:self.headImageBtn
                                                 signTestField:self.personSignTextfield
                                                         label:self.signLabel];
        //头像绑定事件
        [self.headImageBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.personSignTextfield.text = @"王五";
    
    return _headView;
}


#pragma mark --- 创建保存按钮 --

-(UIView *)creatTableViewFootView{

    UIView * footView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView_person.width, 40)];

    //保存按钮
    UIButton * saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat  between = 40;
    saveBtn.frame = CGRectMake(between, 30, footView.width - between *2, 30);
    [saveBtn setBackgroundColor:[UIColor blueColor]];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:saveBtn];

    return footView;
}


#pragma mark --- saveClick: --

-(void)saveBtnClick{
    
    NSLog(@"保存");
//    [self.navigationController popViewControllerAnimated:YES];

}



///  *************      自定义键盘 picker     ************************  //


#pragma mark -- 自定义键盘 picker  --
-(void)_initPickerKeyBoard{
    //pickervKeyBoard
    if (self.pickerKeyBoard == nil) {
        self.pickerKeyBoard = [[PickerKeyBoard alloc] initWithPicker];
        self.pickerKeyBoard.delegate = self;
        [self.view addSubview:self.pickerKeyBoard];
    }
}


#pragma mark -- PickerKeyBoardDelegate --
-(void)pickerKeyBoard:(PickerKeyBoard *)picker selectedText:(NSString *)string{
    
    //身高
    if (picker.tag == 10) {
        
        [self.heightButton setTitle:string forState:UIControlStateNormal];

    }else{
    
        [self.valueArray replaceObjectAtIndex:_currentRow withObject:string];
        //动态刷新cell
      //  [self.tableView_person reloadData];

    }
  //  BMI刷新
    [self   refreshBMI];
    
    [self.tableView_person reloadData];
    
    
//    NSLog(@"-- %ld -- %ld  --%@",weight,height,self.valueArray[2]);
    
    
}

#pragma mark  -- BMI刷新   -
-(void)refreshBMI{
    
    NSInteger  height = [self getCurrentNum:self.heightButton.currentTitle];
    NSInteger  weight = [self getCurrentNum:self.valueArray[0]];
    
    NSString * bmistr =  [MyTool getBMIStringWeight:weight height:height];
    [self.valueArray replaceObjectAtIndex:sorArray.count -1 withObject:bmistr];
    

}

///  *************         从相册区图片-      ************************  //

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


//创建性别身高视图
-(UIView *)createdHeaderInSection{
    
    if (_sexheightView == nil) {
        _sexheightView = [[UIView alloc ] init];
        _sexheightView.bounds = CGRectMake(0, 0, self.tableView_person.width, 80);
        //        _sexheightView.backgroundColor = [UIColor blackColor];
        CGFloat  betwen = 30;
        CGFloat  width = (_sexheightView.width - betwen )/2.0;
        
        //        //性别
        UIView * sexView = [[UIView alloc] init];
        sexView.bounds = CGRectMake(0, 0, width, 50);
        sexView.center = CGPointMake(sexView.width/2.0, _sexheightView.height/2.0);
        sexView.backgroundColor = [UIColor colorWithHexString:@"#fcfcfc"];
        sexView.layer.shadowRadius = 2;
        sexView.layer.shadowColor = [UIColor colorWithHexString:@"#c8c8c8"].CGColor;
        [_sexheightView addSubview:sexView];
        [MyTool cutViewConner:sexView radius:5];
        
        //label 性别
        UILabel * sex_label = [[UILabel alloc] init];
        sex_label.bounds = CGRectMake(0, 0, 35, 25);
        //        sex_label.backgroundColor = [UIColor redColor];
        sex_label.center = CGPointMake(10+ sex_label.width/2.0, sexView.height/2.0);
        sex_label.text = @"性别";
        sex_label.font = FONT(16);
        [sexView addSubview:sex_label];
        
        //性别按钮
        UIButton * sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sexBtn.bounds = CGRectMake(0, 0, 60, 30);
        sexBtn.center = CGPointMake(sex_label.right + 20 + sexBtn.width/2.0, sex_label.center.y);
        //        sexBtn.backgroundColor = [UIColor redColor];
        [sexBtn setTitle:@"女" forState:UIControlStateNormal];
        [sexBtn setTitle:@"男" forState:UIControlStateSelected];
        [sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        [sexBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        sexBtn.titleLabel.font = FONT(16);
        [sexView addSubview:sexBtn];
        self.sexButton = sexBtn;
        
        
        //身高
        UIView * heightView = [[UIView alloc] init];
        heightView.bounds = CGRectMake(0, 0, sexView.width, sexView.height);
        heightView.center = CGPointMake(sexView.right + betwen + heightView.width/2.0, sexView.center.y);
        heightView.backgroundColor = [UIColor colorWithHexString:@"#fcfcfc"];
        heightView.layer.shadowColor = [UIColor colorWithHexString:@"#c8c8c8"].CGColor;
        heightView.layer.shadowRadius = 2;
        [_sexheightView addSubview:heightView];
        [MyTool cutViewConner:heightView radius:5];
        
        //label 身高
        UILabel * height_label = [[UILabel alloc] init];
        height_label.bounds = CGRectMake(0, 0, 35, 25);
        //        height_label.backgroundColor = [UIColor redColor];
        height_label.center = CGPointMake(10+ height_label.width/2.0, heightView.height/2.0);
        height_label.text = @"身高";
        height_label.font = FONT(16);
        [heightView addSubview:height_label];
        
        //身高按钮
        UIButton * heightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        heightBtn.bounds = CGRectMake(0, 0, 60, 30);
        heightBtn.center = CGPointMake(height_label.right + 20 + heightBtn.width/2.0, height_label.center.y);
        //        heightBtn.backgroundColor = [UIColor redColor];
//        [heightBtn setTitle:@"165CM" forState:UIControlStateNormal];
        [heightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [heightBtn addTarget:self action:@selector(heightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        heightBtn.titleLabel.font = FONT(16);
        [heightView addSubview:heightBtn];
        
        self.heightButton = heightBtn;
        [self.heightButton setTitle:@"165CM" forState:UIControlStateNormal];

    }
    
    return _sexheightView;
}


#pragma mark -- 导航条 返回 --

-(void)_initNavs{
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 12, 22.5);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    UIBarButtonItem* letfItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfItem;
}

#pragma mark --返回 --
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获得字符串
-(NSInteger) getCurrentNum:(NSString *)numString{
    
   NSString  * string = [numString substringToIndex:numString.length -2];
    NSInteger num = [string integerValue];
//    NSLog(@"  %@  -- %ld",numString,num);
    return num;
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
