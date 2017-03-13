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
    [_gameView resetGame];
    
    _board = [[GameBoard alloc] initGameWithPlayerNone:_playerNone andPlayer1:_player1 andPlayer2:_player2];
    Player *player = [_mode turn];
    NSUInteger tile = [_mode bestMoveForPlayer:player onGameBoard:_board];
    if (tile == NSUIntegerMax) {
        [_gameView assignTurn:player];
    }
    else {
        [_gameView assignTile:tile toPlayer:player];
        [_gameView assignTurn:[self nextPlayer:player]];
    }
    
}

- (void)player:(Player *)player didMove:(NSUInteger)pos {
    if ([_board makeMoveByPlayer:player move:pos]) {
        [_gameView assignTile:pos toPlayer:player];
        if ([_board isGameOver]) {
            [_gameView assignWinner:[_board whoWonGame]];
        }
        else {
            [_gameView assignTurn:[self nextPlayer:player]];
        }
    }
}

- (Player *)nextPlayer:(Player *)currentPlayer {
    if (currentPlayer == _player1) {
        return _player2;
    }
    else {
        return _player1;
    }
}

- (void)didPressBackButton {
    NSDictionary *lastMoveDict = [_board undoLastMove];
    if (lastMoveDict) {
        Player *lastPlayerToPlay = [lastMoveDict objectForKey:kGameTilePlayerKey];
        NSNumber *lastMove = [lastMoveDict objectForKey:kGameTilePosKey];
        [_gameView assignTile:[lastMove unsignedIntegerValue] toPlayer:nil];
        [_gameView assignTurn:lastPlayerToPlay];
    }
}

@end
