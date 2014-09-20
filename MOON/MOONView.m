//
//  MOONView.m/Users/chris/Desktop/MOONView.m
//  MOON
//
//  Created by Chris Edwards on 8/28/14.
//  Copyright (c) 2014 Duck Brains. All rights reserved.
//

#import "MOONView.h"

@implementation MOONView
#define vSize 540
- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        [self setAutoresizesSubviews:YES];
        
        NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"moon" withExtension:@"mp4"];
        AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithURL:url];
        AVPlayer* player = [AVPlayer playerWithPlayerItem:playerItem];
        [player setActionAtItemEnd:AVPlayerActionAtItemEndNone];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[player currentItem]];
        
        self.playerView = [[AVPlayerView alloc] initWithFrame:CGRectMake(
                                                                         self.bounds.size.width/2 - vSize/2,
                                                                         self.bounds.size.height/2 - vSize/2,
                                                                         vSize, vSize)];
        
        [self.playerView setControlsStyle:AVPlayerViewControlsStyleNone];
        [self.playerView setPlayer:player];
        [self addSubview:self.playerView];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    [[self.playerView player] play];
}

- (void)stopAnimation
{
    [super stopAnimation];
    [[self.playerView player] pause];
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
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

@end
