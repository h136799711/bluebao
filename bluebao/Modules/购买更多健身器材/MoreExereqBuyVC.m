//
//  MoreExereqBuyVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "MoreExereqBuyVC.h"
#import "MoreExerCollectionCell.h"
#import "WebViewController.h"

@interface MoreExereqBuyVC (){
    
    NSArray              *_nameArray;
    NSInteger           itemWidth;
}

@end

@implementation MoreExereqBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购买更多健身器材";
    self.navigationController.navigationBarHidden = NO;

    _nameArray = @[@"天猫",@"京东",@"一号店"];
    
    
    [self _initViews];
}

-(void)_initViews{
    
    [self _initCollectionView];
    [self _initNavs];
}


-(void)_initCollectionView{
    
    CGFloat  left = 30;
    CGFloat  between = 40;
    CGFloat top = 25;
    
    itemWidth = (SCREEN_WIDTH - (left + between) *2)/3.0;

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;      //水平间距
    flowLayout.minimumInteritemSpacing = 20; //垂直间距
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth+25);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);//整体相对页面的位置，上左下右
    //collectionView
    CGRect frame = CGRectMake(left,top,SCREEN_WIDTH- left * 2,180);
    self.collectionView_more = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    self.collectionView_more.scrollEnabled = YES;
    self.collectionView_more.delegate = self;
    self.collectionView_more.dataSource = self;
    self.collectionView_more.alwaysBounceVertical = YES;
    self.collectionView_more.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.collectionView_more];
    
    [self.collectionView_more registerClass:[MoreExerCollectionCell class] forCellWithReuseIdentifier:@"Cell"];

 
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
    //    return dataSource.count;
}

#pragma mark ---collectionViewCell --
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreExerCollectionCell *cell = (MoreExerCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.webImageView.image = [UIImage imageNamed:@""];
    cell.webLabel.text = _nameArray [indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",_nameArray[indexPath.row]);
    
    WebViewController * web = [[WebViewController alloc] init];
    web.title =  _nameArray [indexPath.row];
    [self.navigationController pushViewController:web animated:YES];
    
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
