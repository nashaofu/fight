//
//  FightView.m
//  Fight
//
//  Created by 程刁 on 2018/9/24.
//  Copyright © 2018年 nashaofu. All rights reserved.
//

#import "FightView.h"

@implementation FightView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"fight" withExtension:@"mov"];
        AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithURL:url];
        AVPlayer* player = [AVPlayer playerWithPlayerItem:playerItem];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.AVPlayerView = [[AVPlayerView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(playerItemDidReachEnd:)
            name:AVPlayerItemDidPlayToEndTimeNotification
            object:[player currentItem]];
        [self.AVPlayerView setControlsStyle:AVPlayerViewControlsStyleNone];
        [self.AVPlayerView setPlayer:player];
        [self addSubview:self.AVPlayerView];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    [[self.AVPlayerView player] play];
}

- (void)stopAnimation
{
    [super stopAnimation];
    [[self.AVPlayerView player] pause];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero completionHandler:nil];
    [[self.AVPlayerView player] play];
}

@end
