//
//  AppRedPactketsDistributeSourceModel.m
//  iOS_FanmoreIndiana
//
//  Created by che on 16/3/10.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AppRedPactketsDistributeSourceModel.h"

@implementation AppRedPactketsDistributeSourceModel

+ (instancetype)timeModelWithtime:(int)time {
    
    AppRedPactketsDistributeSourceModel *model = [self new];
    
    return model;
}
//等待倒计时
- (void)WaitCountDown {
    
    
    _startTime -= 1;
}
//结束倒计时
- (void)EndCountDown {
    
    
    _endTime -= 1;
}
//

//等待倒计时
- (NSAttributedString *)WaitCurrentTimeString{
    NSUInteger Ahour = (NSUInteger)(_startTime / 3600);
    NSUInteger Amin  = (NSUInteger)(_startTime % 3600 / 60);
    NSUInteger Asecond = (NSUInteger)(_startTime % 60);
    
    
    NSString *AhourString=[NSString string];
    NSString *AminString=[NSString string];
    NSString *AsecondString=[NSString string];

    if (Ahour < 10) {
        AhourString =[NSString stringWithFormat:@"0%ld",(long)Ahour];
    }else{
        AhourString=[NSString stringWithFormat:@"%ld",(long)Ahour];
    }
    if (Amin < 10) {
        AminString =[NSString stringWithFormat:@"0%ld",(long)Amin];
    }else{
        AminString=[NSString stringWithFormat:@"%ld",(long)Amin];
    }
    if (Asecond < 10) {
        AsecondString =[NSString stringWithFormat:@"0%ld",(long)Asecond];
    }else{
        AsecondString=[NSString stringWithFormat:@"%ld",(long)Asecond];
    }

    if (_startTime  <= 0) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本期活动已开始"]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(0, 7)];
        return attString;
        
    } else if (Amin >= 1){
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 小时%@ 分",AhourString,AminString]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(0, AhourString.length)];
        NSInteger strat = [NSString stringWithFormat:@"%@",AhourString].length + 3 ;
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(strat, AminString.length)];
        return attString;
    } else {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@秒",AsecondString]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(0, AsecondString.length)];
        return attString;
    }
}

//开始倒计时
- (NSString *)EndCurrentTimeString{
    NSUInteger Bhour = (NSUInteger)(_endTime / 3600);
    NSUInteger Bmin  = (NSUInteger)(_endTime % 3600 / 60);
    NSUInteger Bsecond = (NSUInteger)(_endTime % 60);
    NSString *BhourString=[NSString string];
    NSString *BminString=[NSString string];
    NSString *BsecondString=[NSString string];

    if (Bhour < 10) {
        BhourString =[NSString stringWithFormat:@"0%ld",(long)Bhour];
    }else{
        BhourString=[NSString stringWithFormat:@"%ld",(long)Bhour];
    }
    if (Bmin < 10) {
        BminString =[NSString stringWithFormat:@"0%ld",(long)Bmin];
    }else{
        BminString=[NSString stringWithFormat:@"%ld",(long)Bmin];
    }
    if (Bsecond < 10) {
        BsecondString =[NSString stringWithFormat:@"0%ld",(long)Bsecond];
    }else{
        BsecondString=[NSString stringWithFormat:@"%ld",(long)Bsecond];
    }
    
    if (_endTime  <= 0) {
        NSString * BtimeString = @"本期活动已结束";
        return BtimeString;
        
    }else if (Bmin >= 1)
    {
        NSString * BtimeString = [NSString stringWithFormat:@"距离结束还有%@:%@分钟",BhourString,BminString];
        return BtimeString;
    }else {
        NSString * BtimeString = [NSString stringWithFormat:@"距离结束还有%@秒",BsecondString];
        return BtimeString;
    
    }
}



@end
