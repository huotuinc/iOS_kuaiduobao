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
- (void)countDownWait {
    
    
    _startTime -= 1;
}
//结束倒计时
- (void)countDownEnd {
    
    
    _endTime -= 1;
}
//

- (NSAttributedString *)currentTimeStringWait{
    NSUInteger hour = (NSUInteger)(_startTime / 3600);
    NSUInteger min  = (NSUInteger)((_startTime - hour * 3600)/60);
    
    NSString *hourString=[NSString string];
    NSString *minString=[NSString string];
    
    if (hour < 10) {
        hourString =[NSString stringWithFormat:@"0%ld",(long)hour];
    }else{
        minString=[NSString stringWithFormat:@"%ld",(long)hour];
    }
    if (min < 10) {
        minString =[NSString stringWithFormat:@"0%ld",(long)min];
    }else{
        minString=[NSString stringWithFormat:@"%ld",(long)min];
    }

    if (_startTime  <= 0) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本期活动已开始"]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(0, 7)];
//        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(4, 2)];
        return attString;
        
    } else {

        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 小时%@ 分",hourString,minString]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(0, [NSString stringWithFormat:@"%@",hourString].length)];
        NSInteger strat = [NSString stringWithFormat:@"%@",hourString].length + 3 ;
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_SIZE(70)] range:NSMakeRange(strat, [NSString stringWithFormat:@"%@",minString].length)];
        return attString;
    }
}

- (NSString *)currentTimeStringEnd{
    NSUInteger hour = (NSUInteger)(_endTime / 3600);
    NSUInteger min  = (NSUInteger)((_endTime - hour * 3600)/60);
    
    NSString *hourString=[NSString string];
    NSString *minString=[NSString string];
    
    if (hour < 10) {
        hourString =[NSString stringWithFormat:@"0%ld",(long)hour];
    }else{
        minString=[NSString stringWithFormat:@"%ld",(long)hour];
    }
    if (min < 10) {
        minString =[NSString stringWithFormat:@"0%ld",(long)min];
    }else{
        minString=[NSString stringWithFormat:@"%ld",(long)min];
    }
    
    if (_startTime  <= 0) {
        NSString * timeString = @"本期活动已结束";
        return timeString;
        
    } else {
        NSString * timeString = [NSString stringWithFormat:@"距离结束还有%@:%@分钟",hourString,minString];
        return timeString;
    }
}
//- (void) defaultConfig {
//    [self registerNSNotificationCenter];
//}

//#pragma mark - 通知中心
//- (void)registerNSNotificationCenter {
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(AnotificationCenterEvent:)
//                                                 name:NOTIFICATION_RED0_WAIT
//                                               object:nil];
//}
//
//
//- (void)dealloc {
//    
//    [self removeNSNotificationCenter];
//}
//
//- (void)removeNSNotificationCenter {
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_RED_END object:nil];
//}
//
//- (void)AnotificationCenterEvent:(id)sender {
//    
//    [self loadData:self.m_data];
//}


@end
