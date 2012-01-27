//
//  musicPlayer.h
//  Game
//
//  Created by Laurence Wong on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface musicPlayer : NSObject {
	AVAudioPlayer *player;
	MPMediaItem *item;
	int lastDec;
	int threshold;
	int threshbuf;
	int threshmod;
	int threshmodbuf;
}

-(id)initAudioPlayer;
-(int)curLevel;
-(void)update;
@end
