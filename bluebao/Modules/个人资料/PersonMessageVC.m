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
#import "UserUpdataReqModel.h"  //用户信息更新请求模型




@interface PersonMessageVC (){
    
    
    NSArray         * sorArray;
    UIView          * _custemKeyView;  //自定义键盘
    
    UIView          * _headView ;//个人头像个性签名视图
    
    UIView          * _sexheightView; //身高性别
    
    NSInteger         _currentRow;//当前行；
    
    NSArray         *_upDownImagName;
    BOOL            _isAge;  //当前选择的是年龄吗
   
    /**
     *  头像ID
     */
    NSInteger _avatar_id;
}

@end

@implementation PersonMessageVC

//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self.tableView_person reloadData];
//    
//   
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.navigationController.navigationBarHidden = NO;
    _avatar_id = 0;
    _currentRow = 0;
    sorArray = @[@"身高",@"当前体重",@"目标体重",@"BMI"];
    _upDownImagName = @[@"down.png",@"up.png"];
    
    self.userInfo = [MainViewController sharedSliderController].userInfo;
    //处理初始状态
    [self _initInfo];
    
    NSString * heightStr = [self getStrNum:self.userInfo.height unit:@"CM"];
    NSString * weightStr = [self getStrNum:self.userInfo.weight unit:@"KG"];
    NSString * targ_weight = [self getStrNum:self.userInfo.target_weight unit:@"KG"];
    self.valueArray = [[NSMutableArray alloc] initWithObjects:heightStr,weightStr,targ_weight,@"", nil];
    
    
    _isAge = NO;
    //创建视图
    [self _initViews];
}

-(void)_initInfo{
    
    if (self.userInfo.age<= 8) {
        self.userInfo.age = 20;
    }
    if (self.userInfo.height <= 150) {
        self.userInfo.height = 170;
    }
    if (self.userInfo.weight <=30) {
        self.userInfo.weight = 55;
    }
    if (self.userInfo.target_weight <= 30) {
        self.userInfo.target_weight = 55;
    }
}
/*
 *初始化视图
 **/

-(void)_initViews{
    DLog("PersonMessageVC initViews");
    //导航条
    //tableView
    [self _initTableview];
    //自定义键盘
    [self _initPickerKeyBoard];
    //监听Picker位置
    [self _initNotificationCenter ];
    
    //关闭picker手势
    [self _initGest];
}

-(void)peosonInfo{
    
}

#pragma mark ----创建表 ---
-(void)_initTableview{
    
    if (self.tableView_person == nil) {
        CGFloat   left = 20;
        CGFloat h = SCREEN_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT;
        self.tableView_person = [[UITableView alloc]
                                 initWithFrame:CGRectMake(left,0, SCREEN_WIDTH -left *2, h) style:UITableViewStyleGrouped];
        self.tableView_person.rowHeight = 44;
        self.tableView_person.delegate = self;
        self.tableView_person.dataSource = self;
        self.tableView_person.backgroundColor = [UIColor clearColor];
        self.tableView_person.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView_person];
//        [MyTool testViews:self.tableView_person];
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
      UILabel * line =  (UILabel *)[MyTool createLineInView:personCell.contentView
                            fram:CGRectMake(4, personCell.contentView.height, tableView.width - 4*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
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


#pragma mark --- 选中 修改体重，目标体重--
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    //BMI一行不能点击
    if (indexPath.row == sorArray.count -1) {
        
        return;
    }

    _currentRow = indexPath.row;
  
    self.pickerKeyBoard.tag = 0;
    if (indexPath.row == 0) {
        self.pickerKeyBoard.minimumZoom = 150;
        self.pickerKeyBoard.maximumZoom = 250;
        self.pickerKeyBoard.dataUnit = @"CM";

    }else{
       
        self.pickerKeyBoard.minimumZoom = 30;
        self.pickerKeyBoard.maximumZoom = 150;
        self.pickerKeyBoard.dataUnit = @"KG";
        
    }
    //当前体重，
    self.pickerKeyBoard.currentmumZoom = [self getCurrentNum:self.valueArray[indexPath.row]];
   // DLog(@"  --- self.valueArray  - %@ --%ld-",self.valueArray,self.pickerKeyBoard.currentmumZoom);
    
    self.pickerKeyBoard.dataName = sorArray[indexPath.row];
    [self.pickerKeyBoard.pickerView reloadAllComponents];
    
    [self.pickerKeyBoard open];
    self.ageImageBtn.selected = NO;
}
//分区高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

#pragma mark ---- 创建区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self _gettHeaderInSection];
}


#pragma mark -- 年龄 --
-(void)ageBtnClick:(UIButton *)ageImagBtn{
   
    self.ageImageBtn.selected = !self.ageImageBtn.selected;
    
    if ( self.ageImageBtn.selected == YES) {
    
        //当前年龄，
        self.pickerKeyBoard.minimumZoom = 8;
        self.pickerKeyBoard.maximumZoom = 100;

        self.pickerKeyBoard.currentmumZoom =  [self.ageBtn.currentTitle integerValue] ;
        self.pickerKeyBoard.dataName = @"年龄";
        self.pickerKeyBoard.dataUnit = @"";
        
        self.pickerKeyBoard.tag = 10;
        
        [self.pickerKeyBoard.pickerView reloadAllComponents];
        [self.pickerKeyBoard open];
        _isAge = YES;
        
    }else{
        [self.pickerKeyBoard close];
        _isAge = NO;
    }
    DLog(@"   --- age ----");
}


#pragma mark --创建表头--

-(UIView *)creatTableViewHeadView{
    
    if (_headView == nil) {
        //创建个人资料信息（头像签名等）
      
        self.headImageBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        [self.headImageBtn setBackgroundImage:[UIImage imageNamed:@"Default_header"] forState:UIControlStateNormal];
        
        NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userInfo.uid :120]];
        DLog("avatar_url%@",avatar_url);
        [self.headImageBtn setImageWithURL:avatar_url   forState:UIControlStateNormal];
        
        _headView = [BBManageCode  createdPersonInfoShowInView:_headView
                                                       headBtn:self.headImageBtn
                                                 signTestField:self.personSignTextfield
                                                         label:self.signLabel];
        
        //监听触摸
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
        [_headView addGestureRecognizer:singleTap];
        
        //头像绑定事件
        [self.headImageBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _headView;
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
    
}


#pragma mark --- 创建保存按钮 --

-(UIView *)creatTableViewFootView{

    UIView * footView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView_person.width,35)];

    //保存按钮
    UIButton * saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [ButtonFactory decorateButton:saveBtn forType:(BOYE_BTN_SUCCESS)];
    CGFloat  between = 40;
    saveBtn.frame = CGRectMake(between, 0, footView.width - between *2, footView.height);
//    [saveBtn setBackgroundColor:[UIColor blueColor]];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = FONT(18);
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:saveBtn];
    return footView;
}


#pragma mark --- saveClick: 保存  --

-(void)saveBtnClick{
    
    DLog(@"保存");

    
    NSInteger  age = [[self.ageBtn currentTitle] integerValue];
    NSInteger height = [self getCurrentNum:self.valueArray[0]];
    NSInteger weight = [self getCurrentNum:self.valueArray[1]];
    NSInteger target_weight = [self getCurrentNum:self.valueArray[2]];
    
    self.userInfo.age = age;
    self.userInfo.height = height;
    self.userInfo.weight = weight;
    self.userInfo.target_weight = target_weight;
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    self.userInfo.birthday = [NSString stringWithFormat: @"%ld-01-01",(long)(components.year - age + 1)];
    
    UITextField * signature = (UITextField *)[_headView viewWithTag:1002];
    self.userInfo.signature = signature.text;
    
    UITextField * nickname = (UITextField *)[_headView viewWithTag:1001];
    self.userInfo.nickname = nickname.text;
    self.userInfo.sex = 0;
    if(self.sexButton.selected){
        self.userInfo.sex = 1;
    }
    [self requestPersonInfo];
    
}


#pragma mark -- userInfoUpload --

-(void) requestPersonInfo{
    
    //用户信息更新请求模型
    UserUpdataReqModel * updataModel = [[UserUpdataReqModel alloc] init];
    
    updataModel.sex = self.userInfo.sex == 1 ?@"1":@"0" ;
    updataModel.nickname = self.userInfo.nickname;
    updataModel.signature = self.userInfo.signature;
    updataModel.height =  [self getString:self.userInfo.height];
    updataModel.weight =  [self getString:self.userInfo.weight];
    updataModel.target_weight = [self getString:self.userInfo.target_weight];
    updataModel.birthday = self.userInfo.birthday;
    updataModel.uid = self.userInfo.uid;
//    updataModel.avatar_id  = _avatar_id;
    
   __weak  PersonMessageVC *  that = self;
    
    [BoyeDefaultManager requestUserInfoUpdata:updataModel complete:^(BOOL succed) {
        if (succed) {
            
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            [MainViewController sharedSliderController].userInfo = self.userInfo;
            
            double delayInSeconds = 1.0;
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [that.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            
        }

    }];
    
    
    
}


///  *************      自定义键盘 picker     ************************  //


#pragma mark -- 自定义键盘 PickerKeyBoard   --
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
    
    //年龄
    if (picker.tag == 10) {
        [self.ageBtn setTitle:string forState:UIControlStateNormal];

    }else{

        //修改当前数据
        [self.valueArray replaceObjectAtIndex:_currentRow withObject:string];
        //  BMI刷新
        [self   refreshBMI];

    }
     [self.tableView_person reloadData];
}

#pragma mark  -- BMI刷新   -
-(void)refreshBMI{
    
    NSInteger  height = [self getCurrentNum:self.valueArray[0]];
    NSInteger  weight = [self getCurrentNum:self.valueArray[1]];
    
    NSString * bmistr =  [MyTool getBMIStringWeight:weight height:height];
    
    [self.valueArray replaceObjectAtIndex:sorArray.count -1 withObject:bmistr];
    

}

///  *************         从相册区图片-      ************************  //

#pragma mark --- 从相册区图片--

-(void)uploadHeadImage{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:(id)self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍一张照",@"从相册中选", nil];
    [actionSheet showInView:self.view];

    [self.pickerKeyBoard close];

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
        //进入照相界面
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
    
}


#pragma mark  ---   图片选择器    ---

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    
//    if (picker.tabBarItem.tag == 0)
//    {
//        //        //如果是 来自照相机的image，那么先保存
//                UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//                UIImageWriteToSavedPhotosAlbum(original_image, self,
//                                               @selector(image:didFinishSavingWithError:contextInfo:),
//                                              nil);
//    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        
        //先把图片转成NSData
        UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
        [self.headImageBtn setImage:image forState:UIControlStateNormal];
       
        NSData * data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1.0);
            
        }else{
            data = UIImagePNGRepresentation(image);
        }
        
        
        NSString * fileImage =  [BoyeFileMagager getDocumentsImageFile:data userID:self.userInfo.uid];
        
        //图片上传请求
        PictureReqModel * picModel = [[PictureReqModel alloc] init];
        picModel.uid =self.userInfo.uid;
        picModel.type = @"avatar";
        picModel.filePath = fileImage;
        
        [BoyePictureUploadManager requestPictureUpload:picModel :^(NSDictionary *data){
            
            DLog(@" data %@",data);
            
            
            NSURL * avatar_url = [[NSURL alloc]initWithString:[BoyePictureUploadManager getAvatarURL:self.userInfo.uid :120 :YES]];

            [self.headImageBtn setImageWithURL:avatar_url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Default_header"] options:SDWebImageRefreshCached];
            
        } :nil];

  
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}



//创建性别身高视图
-(UIView *)_gettHeaderInSection{
    
    if (_sexheightView == nil) {
        _sexheightView = [[UIView alloc ] init];
        _sexheightView.bounds = CGRectMake(0, 0, self.tableView_person.width, 80);
        CGFloat  betwen = 20;
        CGFloat  width = (_sexheightView.width - betwen )/2.0;
        
        //性别
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
        sex_label.center = CGPointMake(10+ sex_label.width/2.0, sexView.height/2.0);
        sex_label.text = @"性别";
        sex_label.font = FONT(16);
        [sexView addSubview:sex_label];
        
        //下拉按钮图片
        UIButton  * sexImagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sexImagButton.userInteractionEnabled = NO;
        sexImagButton.bounds = CGRectMake(0, 0, 16, 14);
        sexImagButton.center = CGPointMake(sexView.width - 15 - sexImagButton.width/2.0, sex_label.center.y);
        [sexImagButton setImage:[UIImage imageNamed:_upDownImagName[0]] forState:UIControlStateNormal];
        [sexImagButton setImage:[UIImage imageNamed:_upDownImagName[1]] forState:UIControlStateSelected];
        [sexView addSubview:sexImagButton];
        self.sexImageBtn = sexImagButton;
        
        //性别按钮
        UIButton * sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sexBtn.userInteractionEnabled = NO;
        sexBtn.bounds = CGRectMake(0, 0, sexImagButton.left - sex_label.right, 30);
        sexBtn.center = CGPointMake(sex_label.right + sexBtn.width/2.0, sex_label.center.y);
        [sexBtn setTitle:@"女" forState:UIControlStateNormal];
        [sexBtn setTitle:@"男" forState:UIControlStateSelected];
        [sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        sexBtn.titleLabel.font = FONT(17);
        
        [sexView addSubview:sexBtn];
        self.sexButton = sexBtn;
        
     ////  ///////////////////////////////////////////////////////////////////////
        
        //年龄
        UIView * ageView = [[UIView alloc] init];
        ageView.bounds = CGRectMake(0, 0, sexView.width, sexView.height);
        ageView.center = CGPointMake(sexView.right + betwen + ageView.width/2.0, sexView.center.y);
        ageView.backgroundColor = [UIColor colorWithHexString:@"#fcfcfc"];
        ageView.layer.shadowColor = [UIColor colorWithHexString:@"#c8c8c8"].CGColor;
        ageView.layer.shadowRadius = 2;
        [_sexheightView addSubview:ageView];
        [MyTool cutViewConner:ageView radius:5];
        
        //label 年龄
        UILabel * height_label = [[UILabel alloc] init];
        height_label.bounds = CGRectMake(0, 0, 35, 25);
        //        height_label.backgroundColor = [UIColor redColor];
        height_label.center = CGPointMake(10+ height_label.width/2.0, ageView.height/2.0);
        height_label.text = @"年龄";
        height_label.font = FONT(16);
        [ageView addSubview:height_label];
        
        //下拉按钮图片
        self.ageImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ageImageBtn.bounds = CGRectMake(0, 0, sexImagButton.width, sexImagButton.height);
        self.ageImageBtn.center = CGPointMake(sexView.width - 15 - self.ageImageBtn.width/2.0, height_label.center.y);
        self.ageImageBtn.userInteractionEnabled = NO;
        [self.ageImageBtn setImage:[UIImage imageNamed:_upDownImagName[0]] forState:UIControlStateNormal];
        [self.ageImageBtn setImage:[UIImage imageNamed:_upDownImagName[1]] forState:UIControlStateSelected];
        [ageView addSubview:self.ageImageBtn];

        //年龄按钮
        UIButton * ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ageBtn.bounds = CGRectMake(0, 0, self.ageImageBtn.left - height_label.right, 30);
        ageBtn.center = CGPointMake(height_label.right + ageBtn.width/2.0, height_label.center.y);
        ageBtn.userInteractionEnabled = NO;
        [ageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ageBtn.titleLabel.font = FONT(16);
        [ageView addSubview:ageBtn];

        
        NSInteger age = [MainViewController sharedSliderController].userInfo.age;
        self.ageBtn = ageBtn;
        [self.ageBtn setTitle:[NSString stringWithFormat:@"%ld",(long)age] forState:UIControlStateNormal];
        
        // 性别，身高 手势  。。
        //性别初始化 ， 男:1 ， 女:0; 默认女
        UITapGestureRecognizer * sexTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexTapClick:)];
        [self isManOrWenman:self.userInfo.sex];
        [sexView addGestureRecognizer:sexTap];
        
        //身高，
        UITapGestureRecognizer * ageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ageTapClick:)];
        
        [ageView addGestureRecognizer:ageTap];
    }
    
    return _sexheightView;
}


#pragma mark -- **   sex  修改
-(void)sexTapClick:(UITapGestureRecognizer *)tap{
    
    self.sexButton.selected = !self.sexButton.selected;
    self.sexImageBtn.selected = !self.sexImageBtn.selected;
    
    [self.pickerKeyBoard close];
}
//判断男女
-(void) isManOrWenman:(NSInteger) sexIndex{

    if (sexIndex == 1) {  //男
        self.sexButton.selected = YES;
        self.sexImageBtn.selected = YES;

    }else{ //女
        self.sexButton.selected = NO;
        self.sexImageBtn.selected = NO;
    }
}

#pragma mark -- **  age  修改
-(void)ageTapClick:(UITapGestureRecognizer *)tap{
    
    self.ageImageBtn.selected = !self.ageImageBtn.selected;
    
    if ( self.ageImageBtn.selected == YES) {
        
        //当前年龄，
        self.pickerKeyBoard.minimumZoom = 8;
        self.pickerKeyBoard.maximumZoom = 100;
        
        self.pickerKeyBoard.currentmumZoom =  [self.ageBtn.currentTitle integerValue] ;
        self.pickerKeyBoard.dataName = @"年龄";
        self.pickerKeyBoard.dataUnit = @"";
        
        self.pickerKeyBoard.tag = 10;
        
        [self.pickerKeyBoard.pickerView reloadAllComponents];
        [self.pickerKeyBoard open];
        _isAge = YES;
        
    }else{
        [self.pickerKeyBoard close];
        _isAge = NO;
    }
    DLog(@"   --- age ----");

}

//获得字符串
-(NSInteger) getCurrentNum:(NSString *)numString{
    //倒数第二个字符之前的所有字符
   NSString  * string = [numString substringToIndex:numString.length -2];
    NSInteger num = [string integerValue];
//    DLog(@"  %@  -- %ld",numString,num);
    return num;
}



#pragma mark -- 监听picker -- 动画
-(void)_initNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveChangeColorNotification:) name:@"pickerKey" object:nil];

}

#pragma mark -- 接受通知  ---

-(void)receiveChangeColorNotification:(NSNotification *)notification{
    
    
    CGFloat  height = _headView.height + _sexheightView.height + self.tableView_person.rowHeight * 3  - self.outHeight;

     CGFloat origin_x =  [[notification.userInfo objectForKey:@"viewHeightInfo"] floatValue];
    
    
    CGFloat  outheight = height -  origin_x;

    if (outheight > 0) {
        self.tableView_person.contentOffset = CGPointMake(0, outheight);
        self.outHeight  = outheight;
    }else{
        
        if (self.pickerKeyBoard.isOpen == YES) {
            return;
        }else{
            self.tableView_person.contentOffset = CGPointMake(0, 0);

                  self.outHeight = 0;
        }
    }

//    //年龄图标箭头下向下变化
    
    if (self.pickerKeyBoard.isOpen == NO|| self.pickerKeyBoard.tag != 10) {
        self.ageImageBtn.selected = NO;
//        DLog(@" ---");
    }
//
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 数字与字符串拼接  ---
-(NSString * ) getStrNum:(NSInteger) num unit:(NSString *)unit{
    
    NSString * string = [NSString stringWithFormat:@"%ld%@",(long)num,unit];
    return string;
}

-(NSString *) getString:(NSInteger)num{
    return [NSString stringWithFormat:@"%ld",(long)num];
}


#pragma mark -- 目标界面点击手势 关闭picker--
-(void)_initGest{
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
   // [self.view addGestureRecognizer:tap];
    
}
-(void)tapGesture:(UITapGestureRecognizer *)tap{
    //
//    [self.pickerKeyBoard close];
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
