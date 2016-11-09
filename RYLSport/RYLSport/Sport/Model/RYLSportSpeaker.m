//
//  RYLSportSpeaker.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/27.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportSpeaker.h"
#import <NSString+HMNumberConvert.h>
#import <AVFoundation/AVFoundation.h>

@implementation RYLSportSpeaker{
    
    NSString *_typeStr;
    double _lastDistance;
    
//    AVSpeechSynthesizer *_speechSynthesizer;
    
    NSDictionary *_voiceDict;
    
    AVPlayer *_voicePlayer;
    
    NSMutableArray *_voiceArrM;
    
    
}


-(instancetype)init{
    if(self = [super init]){
        
//        _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"voice.json" withExtension:nil subdirectory:@"voice.bundle"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        _voiceDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        _voicePlayer = [[AVPlayer alloc]init];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
        
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)speakeWithType:(RYLSportType)type{
    
    switch (type) {
        case RYLSportTypeRun:
            _typeStr = @"跑步";
            break;
        case RYLSportTypeBike:
            _typeStr = @"骑行";
            break;
        case RYLSportTypeWalk:
            _typeStr = @"步行";
            break;
    }
    
    NSString *text = [@"开始" stringByAppendingString:_typeStr];
    
    [self speakeVoiceWithText:text];
    
}

- (void)speakeWithState:(RYLSportState)state{
    
    NSString *text;
    
    switch (state) {
        case RYLSportStatePause:
            text = @"运动已暂停";
            break;
        case RYLSportStateContinue:
            text = @"运动已恢复";
            break;
        case RYLSportStateFinish:
            text = @"休息一下吧";
            break;
    }
    
    [self speakeVoiceWithText:text];
    
    
}

-(void)speakeWithDistance:(double)distance time:(NSTimeInterval)time avgSpeed:(double)avgSpeed{
    if(distance < _unitDistance + _lastDistance){
        return;
    }
    
    _lastDistance += _unitDistance;
    
    NSString *fmt = @"您已 %@ %@ 公里 用时 %@ 平均速度 %@ 公里每小时 太棒了";
    
    NSString *distanceStr = [NSString hm_numberStringWithNumber:distance hasDotNumber:YES];
    NSString *timeStr = [NSString hm_timeStringWithTimeValue:time];
    NSString *avgSpeedStr = [NSString hm_numberStringWithNumber:avgSpeed hasDotNumber:YES];
    
    NSString *text = [NSString stringWithFormat:fmt,_typeStr,distanceStr,timeStr,avgSpeedStr];
    
    [self speakeVoiceWithText:text];
    
    
}

- (void)speakeVoiceWithText:(NSString *)text{
    
    NSLog(@"开始语音播报 -- %@",text);
    
    NSArray *arr = [text componentsSeparatedByString:@" "];
    
    _voiceArrM = [NSMutableArray arrayWithArray:arr];
    
    [self playFirstVoice];
    
//    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
//    
//    
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
//    
//    
//    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
//    
//    utterance.voice = voice;
//    
//    [_speechSynthesizer speakUtterance:utterance];
    
    
    
    
//    [_voicePlayer replaceCurrentItemWithPlayerItem:];
    
    
    
    
}
- (void)playFirstVoice{
    if(_voiceArrM.count == 0){
        [[AVAudioSession sharedInstance]setActive:NO error:NULL];
        return;
    }
    NSString *firstStr = _voiceArrM.firstObject;
    
    [_voiceArrM removeObjectAtIndex:0];
    
    NSString *mp3 = _voiceDict[firstStr];
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:mp3 withExtension:nil subdirectory:@"voice.bundle"];
    
    if(url == nil){
        [self playFirstVoice];
        
        return ;
    }
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    [_voicePlayer replaceCurrentItemWithPlayerItem:item];
    
    [_voicePlayer play];
    
}

- (void)playerDidEnd:(NSNotification *)noti {
    [self playFirstVoice];
}



@end
