#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CydiaSubstrate.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}
@end

@interface AlarmViewController : TableViewController
-(void)showEditViewForRow:(long long)arg1;
@end

@interface AlarmTableViewCell : UITableViewCell{
    id _alarmView;
}
-(void)setEditing:(BOOL)arg1 animated:(BOOL)arg2;
-(void)setHighlighted:(BOOL)arg1 animated:(BOOL)arg2;
-(void)setSelected:(BOOL)arg1 animated:(BOOL)arg2;
@end


%hook AlarmViewController
%new -(void)tappedCell:(UIButton *)sender{
    [self showEditViewForRow:sender.tag];
}

-(id)tableView:(id)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2{
    UITableViewCell *original = %orig;

    UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
    [tap setFrame:original.frame];
    [tap setBackgroundColor:[UIColor clearColor]];
    [tap addTarget:self action:@selector(tappedCell:) forControlEvents:UIControlEventTouchUpInside];
    [original addSubview:tap];
    tap.tag = arg2.row;

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