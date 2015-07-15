//
//  MoreExereqBuyVC.m
//  bluebao
//
//  Created by boye_mac1 on 15/7/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "MoreExereqBuyVC.h"

@interface MoreExereqBuyVC (){
    
    NSInteger           itemWidth;
}

@end

@implementation MoreExereqBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购买更多健身器材";
    self.navigationController.navigationBarHidden = NO;

    [self _initViews];
}

-(void)_initViews{
    
    [self _initCollectionView];
    [self _initNavs];
}


-(void)_initCollectionView{
    
    itemWidth = (SCREEN_WIDTH - 60-30*2)/3.0;

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 30;      //水平间距
    flowLayout.minimumInteritemSpacing = 30; //垂直间距
//    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth+10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);//整体相对页面的位置，上左下右
    //collectionView
    CGRect frame = CGRectMake(30,0,SCREEN_WIDTH-30*2,180);
    self.collectionView_more = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    self.collectionView_more.scrollEnabled = YES;
    self.collectionView_more.delegate = self;
    self.collectionView_more.dataSource = self;
    self.collectionView_more.alwaysBounceVertical = YES;
    self.collectionView_more.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.collectionView_more];
//    [self.collectionView_more registerClass:[HeadCollectionViewCell class] forCellWithReuseIdentifier:@"HeadCollectionViewCell"];
    

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



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    //    return dataSource.count;
}

#pragma mark ---collectionViewCell --
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (cell== nil) {
        cell = [[UICollectionViewCell alloc] init];
        cell.backgroundColor = [UIColor redColor];
    }
//    cell.labelUnit.text = @"%";
//    cell.infoValue = 10;
//    cell.labelSort.text = _sortArray[indexPath.row];
    return cell;
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
