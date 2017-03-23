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
@property dispatch_block_t scheduledComputerMove;

@end

@implementation Game

- (id)initWithGameView:(GameViewController *)gameView {
    if (self = [super init]) {
        _gameView = gameView;
        _playerNone = [[Player alloc] init];
        
        _player1 = [[Player alloc] initWithName:@"User"
                                                andTag:1
                                              andImage:[[UIImage imageNamed:@"Spades"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                              andColor:[UIColor blueColor]
                                        andType:PlayerTypeUser];
        
        _player2 = [[Player alloc] initWithName:@"Computer"
                                                andTag:2
                                              andImage:[[UIImage imageNamed:@"Hearts"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                              andColor:[UIColor redColor]
                                        andType:PlayerTypeComputer];
        
        _mode = [[GameModeBeginner alloc] initWithPlayer1:_player1 andPlayer2:_player2];
    }
    
    return self;
}

- (void)startNewGame {
    [_gameView resetGame];
    
    _board = [[GameBoard alloc] initGameWithPlayerNone:_playerNone andPlayer1:_player1 andPlayer2:_player2];
    Player *player = [_mode turn];
    
    if ([player type] == PlayerTypeComputer) {
        [self makeComputerMoveForPlayer:player];
    }
    else {
        [_gameView assignTurn:player];
    }
}

- (void)player:(Player *)player didMove:(NSUInteger)pos {
    [self handleMoveToTile:pos byPlayer:player];
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
    [self cancelScheduledComputerMove];
    
    NSDictionary *lastMoveDict = [_board undoLastMove];
    if (lastMoveDict) {
        Player *lastPlayerToPlay = [lastMoveDict objectForKey:kGameTilePlayerKey];
        NSNumber *lastMove = [lastMoveDict objectForKey:kGameTilePosKey];
        [_gameView assignTile:[lastMove unsignedIntegerValue] toPlayer:nil];
        if ([lastPlayerToPlay type] == PlayerTypeComputer) {
            [self makeComputerMoveForPlayer:lastPlayerToPlay];
        }
        else {
            [_gameView assignTurn:lastPlayerToPlay];
        }
    }
}

- (void)makeComputerMoveForPlayer:(Player *)player {
    [_gameView assignTurn:player];
    
    [self cancelScheduledComputerMove];
    _scheduledComputerMove = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        NSUInteger tile = [_mode bestMoveForPlayer:player onGameBoard:_board];
        [self handleMoveToTile:tile byPlayer:player];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   _scheduledComputerMove);
}

- (void)handleMoveToTile:(NSUInteger)pos byPlayer:(Player *)player {
    if ([_board makeMoveByPlayer:player move:pos]) {
        [_gameView assignTile:pos toPlayer:player];
        if ([_board isGameOver]) {
            [_gameView assignWinner:[_board whoWonGame]];
        }
        else {
            Player *nextPlayer = [self nextPlayer:player];
            if ([nextPlayer type] == PlayerTypeComputer) {
                [self makeComputerMoveForPlayer:nextPlayer];
            }
            else {
                [_gameView assignTurn:nextPlayer];
            }
        }
    }
}

- (void)cancelScheduledComputerMove {
    if (_scheduledComputerMove) {
        dispatch_block_cancel(_scheduledComputerMove);
        _scheduledComputerMove = NULL;
    }
}

@end
