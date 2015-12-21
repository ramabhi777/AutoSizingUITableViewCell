//
//  ViewController.m
//  AutoSizingUITableViewCell
//
//  Created by Abhishek Shukla on 01/10/15.
//  Copyright (c) 2015 InnovationM. All rights reserved.
//

#import "ViewController.h"
#import "DynamicHeightTableViewCell.h"

static NSString * const physicalIdentifier = @"StoreIdentifier";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
{
    NSMutableArray *storeLocationArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Dynamic TableCell"];
    storeLocationArray = [[NSMutableArray alloc] init];
    [storeLocationArray addObject:@"Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"2 Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"3 Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"4 Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"5 Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"6 Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@" 7 Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@" 8 Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"9 Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib."];
        [storeLocationArray addObject:@"10 Do any additional setup after loading the view, typically from a nib Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return storeLocationArray.count;
}

// Height of the tabel row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForBasicCellAtIndexPath:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self basicCellAtIndexPath:indexPath];
}

- (DynamicHeightTableViewCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicHeightTableViewCell *cell = [self getPhysicalStoreCell];
    [self configureBasicCell:cell atIndexPath:indexPath.row];
    return cell;
}

- (DynamicHeightTableViewCell *) getPhysicalStoreCell
{
    DynamicHeightTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:physicalIdentifier];
    return cell;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSUInteger)indexPathRow {
    
    static DynamicHeightTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self getPhysicalStoreCell];
        
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPathRow];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (void)configureBasicCell:(DynamicHeightTableViewCell *)cell atIndexPath:(NSUInteger)indexPathRow
{
    NSString *item = [storeLocationArray objectAtIndex:indexPathRow];
    [self setTitleForCell:cell item:item cellIndexPath:indexPathRow];
}

- (void)setTitleForCell:(DynamicHeightTableViewCell *)cell item:(NSString *)item cellIndexPath:(NSUInteger)indexPathRow
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.lblContent setText:item];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
{
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSAttributedString *)getStoreForTableRow:(NSString *)store
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:store];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, store.length)];
    return attributedString;
}

@end
