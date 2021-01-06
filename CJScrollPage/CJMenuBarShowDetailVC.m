//
//  CJMenuBarShowDetailVC.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/28.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "CJMenuBarShowDetailVC.h"
#import "CJMenuCell.h"
#import "CJScrollPageConst.h"

#define CJRowCount 3
#define CJMargin 6
#define CJCellH 30

@interface CJMenuBarShowDetailVC ()

@end

@implementation CJMenuBarShowDetailVC

static NSString * const reuseIdentifier = @"menuCell";

-(void)setItems:(NSArray<id<CJSegmentModelProtocol>> *)items{
    _items = items;
    
    NSInteger rows = (_items.count + (CJRowCount - 1))/CJRowCount;
    CGFloat height = rows * (CJCellH + CJMargin);
    self.collectionView.CJ_height = height;
    self.expectedHeight = height;
    [self.collectionView reloadData];
}
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (CJScreenWidth - CJMargin * (CJRowCount + 1))/CJRowCount;
        CGFloat height = CJCellH;
        flowLayout.minimumLineSpacing = CJMargin;
        flowLayout.minimumInteritemSpacing = CJMargin;
        flowLayout.itemSize = CGSizeMake(width, height);
//        flowLayout.sectionInset = UIEdgeInsetsMake(CJMargin*0.5, 0, 0, 0);
    
    return [super initWithCollectionViewLayout:flowLayout];
}
- (instancetype)init{
    return [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CJMenuCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CJMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.menueLabel.text = (NSString *)self.items[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
