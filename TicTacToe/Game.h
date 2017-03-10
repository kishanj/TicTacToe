//
//  Game.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/7/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "GameBoard.h"
#import "GameModeManual.h"

@class GameViewController;

@interface Game : NSObject

@property (nonatomic, strong) GameMode *mode;
@property (nonatomic, strong) Player *playerNone;
@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;
@property (nonatomic, strong) GameBoard *board;

- (id)initWithGameView:(GameViewController *)gameView;
- (void)startNewGame;

- (void)player:(Player *)player didMove:(NSUInteger)pos;
- (void)didPressBackButton;

@end
