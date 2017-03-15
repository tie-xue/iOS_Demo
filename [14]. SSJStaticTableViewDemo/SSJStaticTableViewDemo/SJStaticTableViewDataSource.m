//
//  SJStaticTableViewDataSource.m
//  SSJStaticTableViewDemo
//
//  Created by Sun Shijie on 2017/3/15.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "SJStaticTableViewDataSource.h"
#import "SSJStaticTableviewCellViewModel.h"
#import "SSJStaticTableviewSectionViewModel.h"
#import "SJStaticTableViewCell.h"

@interface SJStaticTableViewDataSource()

@property (nonatomic, copy) SJStaticCellConfigureBlock cellConfigureBlock;

@end


@implementation SJStaticTableViewDataSource

- (instancetype)initWithViewModelsArray:(NSArray *)viewModelsArray configureBlock:(SJStaticCellConfigureBlock)block
{
    self = [super init];
    if (self) {
        self.viewModelsArray = viewModelsArray;
        self.cellConfigureBlock = [block copy];
    }
    return self;
}

- (SSJStaticTableviewCellViewModel *)tableView:(UITableView *)tableview cellViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModelsArray.count > indexPath.section) {
        SSJStaticTableviewSectionViewModel *sectionViewModel = [self.viewModelsArray objectAtIndex:indexPath.section];
        if (sectionViewModel.itemArray.count > indexPath.row) {
            return [sectionViewModel.itemArray objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (SSJStaticTableviewSectionViewModel *)tableView:(UITableView *)tableView sectionViewModelInSection:(NSInteger )section
{
    if (self.viewModelsArray.count > section) {
        return [self.viewModelsArray objectAtIndex:section];
    }
    return nil;
}

#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModelsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SSJStaticTableviewSectionViewModel *sectionViewModel = self.viewModelsArray[indexPath.section];
    SSJStaticTableviewCellViewModel *cellViewModel = sectionViewModel.itemArray[indexPath.row];
    
    SJStaticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellViewModel.cellID];
    if (!cell) {
        cell = [[SJStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellViewModel.cellID];
    }
    self.cellConfigureBlock(cell,cellViewModel);
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.sectionHeaderTitle;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.sectionFooterTitle;
}

@end
