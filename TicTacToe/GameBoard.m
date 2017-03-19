//
//  GameBoard.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/8/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "GameBoard.h"

const NSUInteger kNumTiles = 9;
NSString * const kGameTilePosKey = @"Pos";
NSString * const kGameTilePlayerKey = @"Player";

@interface GameBoard()

@property (nonatomic, strong, nullable) NSMutableArray<Player *> *tiles;
@property (nonatomic, strong, nullable) NSMutableArray *moves;

@property (nonatomic, strong, nonnull) Player *playerNone;
@property (nonatomic, strong, nonnull) Player *player1;
@property (nonatomic, strong, nonnull) Player *player2;

@end

@implementation GameBoard

+ (NSUInteger)tilesOnBoard {
    return kNumTiles;
}

- (nonnull id)initGameWithPlayerNone:(nonnull Player *)playerNone andPlayer1:(nonnull Player *)player1 andPlayer2:(nonnull Player *)player2 {
    if (self = [super init]) {
        _playerNone = playerNone;
        _player1 = player1;
        _player2 = player2;
        
        _tiles = [[NSMutableArray alloc] initWithCapacity:kNumTiles];
        for(NSInteger i=0; i<kNumTiles; i++) {
            [_tiles addObject:playerNone];
        }
        _moves = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (BOOL)makeMoveByPlayer:(nonnull Player *)player move:(NSUInteger)pos {
    if (pos >= kNumTiles) {
        NSLog(@"move position out of range: %lu", (unsigned long)pos);
    }
    if (_tiles[pos] != _playerNone) {
        NSLog(@"Position [%lu] already filled by Player %@", (unsigned long)pos, [_tiles[pos] name]);
    }
    else {
        _tiles[pos] = player;
        [_moves addObject:@{kGameTilePosKey:[NSNumber numberWithUnsignedInteger:pos], kGameTilePlayerKey:player}];
        return TRUE;
    }
    
    return FALSE;
}

- (NSDictionary *)undoLastMove {
    if (_moves.count) {
        NSDictionary *lastMoveDict = [_moves lastObject];
        [_moves removeLastObject];
        NSNumber *lastMove = [lastMoveDict objectForKey:kGameTilePosKey];
        [_tiles replaceObjectAtIndex:[lastMove unsignedIntegerValue] withObject:_playerNone];
        return lastMoveDict;
    }
    
    return nil;
}

- (BOOL)isGameOver {
    if ((_moves.count == kNumTiles) ||
        ([self whoWonGame] != nil)) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

- (nullable Player *)whoWonGame {

    if ([self didPlayerWinGame:_player1]) {
        return _player1;
    }
    else if ([self didPlayerWinGame:_player2]) {
        return _player2;
    }
    else {
        return nil;
    }
}

- (BOOL)didPlayerWinGame:(nonnull Player *)player {
    if ((_tiles[0] == player && _tiles[1] == player && _tiles[2] == player) || // row 1
        (_tiles[3] == player && _tiles[4] == player && _tiles[5] == player) || // row 2
        (_tiles[6] == player && _tiles[7] == player && _tiles[8] == player) || // row 3
        (_tiles[0] == player && _tiles[3] == player && _tiles[6] == player) || // column 1
        (_tiles[1] == player && _tiles[4] == player && _tiles[7] == player) || // column 2
        (_tiles[2] == player && _tiles[5] == player && _tiles[8] == player) || // column 3
        (_tiles[0] == player && _tiles[4] == player && _tiles[8] == player) || // forward diagonal
        (_tiles[2] == player && _tiles[4] == player && _tiles[6] == player)) // backward diagonal
        return TRUE;
    
    return FALSE;
}

- (nullable NSArray *)vacantTiles {
    NSMutableArray *vacantTiles = [[NSMutableArray alloc] initWithCapacity:kNumTiles];
    for(NSInteger i=0; i<kNumTiles; i++) {
        if (_tiles[i] == _playerNone) {
            [vacantTiles addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    return vacantTiles;
}

@end
