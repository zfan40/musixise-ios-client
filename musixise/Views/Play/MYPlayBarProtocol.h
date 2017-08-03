//
//  MYPlayBarProtocol.h
//  musixise
//
//  Created by wmy on 2017/4/25.
//  Copyright © 2017年 wmy. All rights reserved.
//

#ifndef MYPlayBarProtocol_h
#define MYPlayBarProtocol_h

@class MYPlayerBar;

typedef enum {
    MYPlayerModeType_List = 0,
    MYPlayerModeType_Single = 1,
    MYPlayerModeType_Random = 2,
    MYPlayerModeType_Count = 3,
} MYPlayerModeType;

@protocol MYPlayerBarProtocol <NSObject>

- (void)playerBarDidClickNextButton:(MYPlayerBar *)playerBar;
- (void)playerBarDidClickPreButton:(MYPlayerBar *)playerBar;
- (void)playerBar:(MYPlayerBar *)playerBar didClickPlayButton:(BOOL)isPlay;
- (void)playerBarDidClickMoreButton:(MYPlayerBar *)playerBar;
- (void)playerBar:(MYPlayerBar *)playerBar didChangePlayMode:(MYPlayerModeType)type;

@end



#endif /* MYPlayBarProtocol_h */
