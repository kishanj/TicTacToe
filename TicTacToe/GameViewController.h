//
//  GameViewController.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/3/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@class Game;

@interface GameViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic, nullable) Game *game;

- (void)resetGame;
- (void)assignPlayer:(nullable Player *)player toTile:(NSUInteger)tag;
- (void)assignTurn:(nullable Player *)player;
- (void)resetStats;
- (void)displayCommand:(nullable NSString *)command;

@end

