//
//  ViewController.m
//  MMSwipeToDeleteCollection
//
//  Created by Photo on 8/19/13.
//  Copyright (c) 2013 MacCDevTeam LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteSwipedCell:) name:@"DeleteSwipedCellNotification" object:nil];

    self.dataArray = [NSMutableArray new];
    for (int i = 0 ; i < 100 ; i ++) {
        [self.dataArray addObject:[NSNull null]];
    }
}

- (void)deleteSwipedCell:(NSNotification *)sender
{
    NSLog(@"%@",sender.object);
    NSIndexPath *indexPathToDelete = sender.object;
    
    [self.dataArray removeObjectAtIndex:indexPathToDelete.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPathToDelete]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (SwipeableCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELLID";
    SwipeableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    return cell;
}


@end
