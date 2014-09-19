//
//  MOONView.h
//  MOON
//
//  Created by Chris Edwards on 8/28/14.
//  Copyright (c) 2014 Duck Brains. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVPlayerView.h>

@interface MOONView : ScreenSaverView

@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic, strong) AVPlayerView* playerView;

@end
