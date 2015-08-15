//
//  PeopleBodyParams.m
//  bluebao
//
//  Created by hebidu on 15/8/15.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "PeopleBodyParams.h"

@implementation PeopleBodyParams

//typedef enum{
//    FAT_
//    FAT_NORMAL,
//    
//}FAT_LEVEL;

+(float)getBMI:(float )weight :(float)height{
    return weight / (height*height);
}



/**
 *
 *  ①BMI=体重（公斤）÷（身高×身高）（米）
 *  ②体脂率：1.2×BMI+0.23×年龄-5.4-10.8×性别（男为1，女为0
 *
 */
+(NSInteger )getBodyFatRateBy:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height{
    float rate = [self getBMI:weight :height];
    
    rate = (1.2*rate  + 0.23 * age -5.4 - 10.8*sex);
    NSLog(@"体脂肪率%ld",(long)rate);
    return (NSInteger)rate;
}

+(NSInteger )getBodyWaterRateBy:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height{
    
    float rate = 0;
    if(sex == 0){
        
        if(age > 30){
            //51.5-48.1%
            rate = 0.481 + 0.034*(age/60 -  0.5);
            
        }else{
            //52.9-49.5%
            rate = 0.495 + 0.034*(1-age/30);
        }
        
    }else{
        if(age > 30){
            //55.6-52.3%
            rate = 0.523 + 0.033*(age/60 -  0.5);
            
        }else{
            //57.0-53.6%
            rate = 0.536 + 0.033*(1 - age/30);
            
        }
        
        
    }
    
    
    return (NSInteger ) (rate*100);
}

+(NSInteger )getBasalMetabolicRate:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height{
    
    
    /**
     *
     男
  0-3岁   60.9m — 54                          0.2550m — 0.226
   3-10岁    22.7m + 495                         0.0949m + 2.07
   10-18岁  17.5m + 651                         0.0732m +2.72
  18-30   15.3m + 679                         0.0640m +2.84
   》30    11.6m + 879                         0.0485m + 3.67
   
     
     
     女
  0-3岁      61.0m — 51                         0.2550m — 0.214
  3-10岁    22.5m +499                         0.9410m +2.09
  10-18岁 12.2m +746                         0.0510m +3.12
  18-30     14.7m +496                         0.0615m +2.08
  》30       8.7m +820                           0.0364m +3.47
     
     
     
     
     
     */
    
    
    
    return 13;
}

+(NSInteger)getViscusPate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    
    return 2;
}

+(NSInteger)getSkeletonRate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    if(sex == 0){
        
        if(age < 39){
            return 1.7;
        }else if(age >39 && age < 60){
            return 2.1;
        }else{
            return 2.4;
        }
        
    }else{
        
        if(age < 54){
            return 2.4;
        }else if(age > 54 && age < 75){
            return 2.8;
        }else{
            return 3.1;
        }
    }
    
}

+(NSInteger) getSubcutaneousFatRate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    return 5;
}

+(NSInteger)getMusclePate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    if (sex == 0) {
        if (height < 1.6) {
            //31.9+- 2.8
            return 31.9;
            
        }else if(height >= 1.6 && height <= 1.7){
            //35.2+-2.3
            return 35.2;

        }else{
            //39.5+-3
            return 39.5;
        }
        
    }else{
        if (height < 1.6) {
            //31.9+- 2.8
            return 31.9;
            
        }else if(height >= 1.6 && height <= 1.7){
            //35.2+-2.3
            return 35.2;
        }else{
            //39.5+-3
            return 39.5;
        }
    }
    
}

+(NSInteger )getBodyAge:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height{
    return age;
}



@end
