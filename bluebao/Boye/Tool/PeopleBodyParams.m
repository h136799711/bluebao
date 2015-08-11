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
//    NSLog(@"体脂肪率%ld",(long)rate);
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
    
    
   // Harris-Benedict公式
   // 男性: BMR = 66+(13.7× 体重(kg))+(5×身高(cm)) – (6.8×年龄(岁))
   // 女性: BMR = 655+(9.6×体重(kg))+(1.8×身高(cm))–(4.7×年龄(岁))
    
   // The Mufflin equation
   // 男性: RMR=(10×体重(kg))+(6.25×身高(cm))-(5×年龄(岁)) + 5
   // 女性: RMR=(10×体重(kg))+(6.25×身高(cm))-(5×年龄(岁)) - 161
    
    // 一个更准确的计算公式是以瘦体重为基础的Katch-McArdle公式
    
    // Katch-McArdle公式
    // BMR/RMR(男性与女性)=370+(21.6*瘦体重(kg))
//    S（m2）=0.0061×身高（cm）+0.0128×体重（kg）-0.1529
    
//    float S = 0.0061 * (height*100)+ 0.0128 * weight - 0.1529;
    float bmr = 0;
    if(sex == 0){
        bmr = 66 + (13.7 * weight)+( 5 * height *100) - ( 6.8 * age);
    }else{
        bmr = 6655+ (9.6 * weight)+( 1.8 * height *100) - ( 4.7 * age);
    }
    
    float normalBMR = [self getNormalBMR:age :sex :weight :height ];
    
    bmr = 100*normalBMR/bmr - 100;
    NSLog(@"bmr=%d",(int)bmr);
    if(bmr < 0){
        bmr = bmr * -1;
    }
    
    return (int)bmr;
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

+(NSInteger)getViscusPate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    float bmi = [self getBMI:weight :height];
    
    if (bmi <25) {
        return (int)(( bmi / 25) * 9  );
    }else if(bmi < 35){
        return (int)(( bmi / 35) * 14  );
    }
    
    return (int)((bmi / 40) * 30);
}

+(NSInteger) getSubcutaneousFatRate:(NSInteger)age :(NSInteger)sex :(float)weight :(float)height{
    
    float fatRate = [self getBodyFatRateBy:age :sex :weight :height];
    
    
    return fatRate*0.1532;
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

+(float)getNormalBMR:(NSInteger )age :(NSInteger )sex :(float )weight :(float)height{
    if(sex == 0){
        return 1210;
    }else{
        return 1550;
    }
    
}

@end
