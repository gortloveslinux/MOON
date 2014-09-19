//
//  MOONView.m/Users/chris/Desktop/MOONView.m
//  MOON
//
//  Created by Chris Edwards on 8/28/14.
//  Copyright (c) 2014 Duck Brains. All rights reserved.
//

#import "MOONView.h"

@implementation MOONView

static const NSString *ItemStatusContext;

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        [self setAutoresizesSubviews:YES];
        
        NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"moon" withExtension:@"mp4"];
        AVURLAsset* avurlAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
        AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithAsset:avurlAsset];
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
        
        [self.player setActionAtItemEnd:AVPlayerActionAtItemEndNone];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[self.player currentItem]];
        
        self.playerView = [[AVPlayerView alloc] initWithFrame:[self bounds]];
        [self.playerView setControlsStyle:AVPlayerViewControlsStyleNone];
        [self.playerView setPlayer:self.player];
        [self addSubview:self.playerView];
        [self.player play];
        


    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    //[super stopAnimation];
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
