#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@end

%hook TableViewController
%new -(void)userPressedMoreButton:(UIButton *)button{
    NSLog(@"---- more!");
}

%new -(void)userPressedDeleteButton:(UIButton *)button{
    NSLog(@"---- delete!");
}

-(UIBarButtonItem *)editButtonItem{
	return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = %orig; 

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds))];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(cell.bounds) + 100.f, CGRectGetHeight(cell.bounds));
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [cell.contentView addSubview:scrollView];
 
    UIView *scrollViewButtonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.bounds) - 100.f, 0.f, 100.f, CGRectGetHeight(cell.bounds))];
    scrollViewButtonView.tag = 1;
    [scrollView addSubview:scrollViewButtonView];
 
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.backgroundColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f];
    moreButton.frame = CGRectMake(0.f, 0.f, 50.f, CGRectGetHeight(cell.bounds));
    [moreButton setTitle:@"More" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(userPressedMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewButtonView addSubview:moreButton];
 
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0f];
    deleteButton.frame = CGRectMake(50.f, 0.f, 50.f, CGRectGetHeight(cell.bounds));
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(userPressedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewButtonView addSubview:deleteButton];
     
    UIView *scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds))];
    scrollViewContentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:scrollViewContentView];
     
    UILabel *scrollViewLabel = [[UILabel alloc] initWithFrame:CGRectInset(scrollViewContentView.bounds, 10.f, 0.f)];
    [scrollViewContentView addSubview:scrollViewLabel];

	return cell;
}

-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2{
	return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x < 0)
        scrollView.contentOffset = CGPointZero; 
 
    [scrollView viewWithTag:1].frame = CGRectMake(scrollView.contentOffset.x + (CGRectGetWidth(scrollView.bounds) - 50.f), 0.f, 50.f, CGRectGetHeight(scrollView.bounds)); 
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(CGPoint)targetContentOffset{
    if(scrollView.contentOffset.x > 50.f)
        targetContentOffset.x = 50.f;

    else
        dispatch_async(dispatch_get_main_queue(), ^{ [scrollView setContentOffset:CGPointZero animated:YES]; });
}
%end