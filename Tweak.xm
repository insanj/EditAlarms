#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "substrate.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end

@interface AlarmViewController : TableViewController

- (void)showEditViewForRow:(long long)arg1;

@end

%hook AlarmViewController
static BOOL editAlarms_shouldIgnoreTaps;

%new - (void)editAlarmsButtonTapped:(UIButton *)sender {
    UITableView *tableView = MSHookIvar<UITableView *>(self, "_tableView");
  
    if (editAlarms_shouldIgnoreTaps) {
        editAlarms_shouldIgnoreTaps = NO;
    }

    else {
        [self showEditViewForRow:[tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row];
    }
}

%new - (void)editAlarmsButtonCancelled:(UIButton *)sender {
    editAlarms_shouldIgnoreTaps = YES;
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2 {
    UITableViewCell *cell = %orig;

    CGRect editAlarmsButtonFrame = cell.frame;
    editAlarmsButtonFrame.size.width /= 2.0;

    UIButton *editAlarmsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editAlarmsButton.frame = editAlarmsButtonFrame;
    editAlarmsButton.backgroundColor = [UIColor clearColor];
    [editAlarmsButton addTarget:self action:@selector(editAlarmsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [editAlarmsButton addTarget:self action:@selector(editAlarmsButtonCancelled:) forControlEvents:UIControlEventTouchDragInside];
    [cell addSubview:editAlarmsButton];

    return cell;
}

- (UIBarButtonItem *)editButtonItem {
    return nil;
}

- (BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2 {
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

%end
