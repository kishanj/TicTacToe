//
//  Game.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/7/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "Game.h"
#import "GameViewController.h"

@interface Game()

@property (nonatomic, weak) GameViewController *gameView;

@end

@implementation Game

- (id)initWithGameView:(GameViewController *)gameView {
    if (self = [super init]) {
        _gameView = gameView;
        _playerNone = [[Player alloc] init];
        
        _player1 = [[Player alloc] initWithName:@"Alice"
                                                andTag:1
                                              andImage:[[UIImage imageNamed:@"Hearts"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                              andColor:[UIColor redColor]];
        
        _player2 = [[Player alloc] initWithName:@"Bob"
                                                andTag:2
                                              andImage:[[UIImage imageNamed:@"Spades"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                              andColor:[UIColor blueColor]];
        
        _mode = [[GameModeManual alloc] initWithPlayer1:_player1 andPlayer2:_player2];
    }
    
    return self;
}

- (void)startNewGame {
    _board = [[GameBoard alloc] initGameWithPlayerNone:_playerNone andPlayer1:_player1 andPlayer2:_player2];
    Player *player = [_mode turn];
    [_gameView assignTurn:player];
    NSUInteger tile = [_mode bestMoveForPlayer:player onGameBoard:_board];
    if (tile == NSUIntegerMax) {
        [_gameView displayCommand:[NSString stringWithFormat:@"It is %@'s turn", [player name]]];
    }
    else {
        [_gameView assignPlayer:player toTile:tile];
        
    }
    
}

- (void)player:(Player *)player didMove:(NSUInteger)pos {
    if ([_board makeMoveByPlayer:player move:pos]) {
        [_gameView assignPlayer:player toTile:pos];
        Player *nextPlayer;
        if (player == _player1) {
            nextPlayer = _player2;
        }
        else {
            nextPlayer = _player1;
        }
        
        [_gameView assignTurn:nextPlayer];
        [_gameView displayCommand:[NSString stringWithFormat:@"It is %@'s turn", [nextPlayer name]]];
    }
}

- (void)didPressBackButton {
    
}

@end
