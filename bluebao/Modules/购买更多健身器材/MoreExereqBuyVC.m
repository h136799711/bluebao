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
    NSArray              *_urlStringName;
    NSInteger            itemWidth;
    NSArray              *_scImagName;
}

@end

@implementation MoreExereqBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购买更多健身器材";
    self.navigationController.navigationBarHidden = NO;


    _urlStringName = @[@"https://lanbao.m.tmall.com/",@"http://ok.jd.com/m/index-24454.htm",@"http://m.yhd.com/store/m-156767-6.html"];
    
    _nameArray = @[@"天猫",@"京东",@"一号店"];
    _scImagName = @[@"tmall.png",@"jd.png",@"1hao.png"];
    [self _initViews];
}

-(void)_initViews{
    
    [self _initCollectionView];
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

    cell.webImageView.image = [UIImage imageNamed:_scImagName[indexPath.row]];
    cell.webLabel.text = _nameArray [indexPath.row];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DLog(@"%@",_nameArray[indexPath.row]);
//    
//    WebViewController * web = [[WebViewController alloc] init];
//    web.urlString = _urlStringName[indexPath.row];
//    DLog(@" indexPath   %ld ",indexPath.row);
//    web.title =  _nameArray [indexPath.row];
//    [self.navigationController pushViewController:web animated:YES];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlStringName[indexPath.row]]];

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
