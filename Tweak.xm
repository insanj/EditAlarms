#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CydiaSubstrate.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@end

@interface AlarmViewController : TableViewController
-(void)showEditViewForRow:(long long)arg1;
@end

%hook AlarmViewController
BOOL shouldIgnore;

%new -(void)tappedCell:(UIButton *)sender{
    UITableView *tableView = MSHookIvar<UITableView *>(self, "_tableView");
    if(shouldIgnore)
        shouldIgnore = NO;
    else
        [self showEditViewForRow:[tableView indexPathForCell:(UITableViewCell*)sender.superview.superview].row];
}

%new -(void)cancelCellTap{
    shouldIgnore = YES;
}


-(id)tableView:(id)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2{
    UITableViewCell *original = %orig;

    UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect croppedFrame = original.frame;
    croppedFrame.size.width /= 2.f;
    [tap setFrame:croppedFrame];
    [tap setBackgroundColor:[UIColor clearColor]];
    [tap addTarget:self action:@selector(tappedCell:) forControlEvents:UIControlEventTouchUpInside];
    [tap addTarget:self action:@selector(cancelCellTap) forControlEvents:UIControlEventTouchDragInside];
    [original addSubview:tap];

    return original;
}

-(UIBarButtonItem *)editButtonItem{
    return nil;
}

-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2{
	return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

%end