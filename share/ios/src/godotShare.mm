#include "godotShare.h"


#import "app_delegate.h"


GodotShare::GodotShare() {
    ERR_FAIL_COND(instance != NULL);
    instance = this;
}

GodotShare::~GodotShare() {
    instance = NULL;
}



void GodotShare::shareText(const String &title, const String &subject, const String &text) {
    
    ViewController *root_controller = (ViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    
    NSString * message = [NSString stringWithCString:text.utf8().get_data() encoding:NSUTF8StringEncoding];
    
    NSArray * shareItems = @[message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    if ( [avc respondsToSelector:@selector(popoverPresentationController)] ) {
        // iOS8
        avc.popoverPresentationController.sourceView = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window;
    }
    
//    //if iPhone
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//
//        [self presentViewController:controller animated:YES completion:nil];
//        [root_controller presentViewController:avc animated:YES completion:nil];
//    }
//    //if iPad
//    else {
//        // Change Rect to position Popover
//        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
//        [popup presentPopoverFromRect:CGRectMake(avc.view.frame.size.width/2, root_controller.view.frame.size.height/4, 0, 0)inView:avc.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
    
    [root_controller presentViewController:avc animated:YES completion:nil];

}

void GodotShare::sharePic(const String &path, const String &title, const String &subject, const String &text) {
    ViewController *root_controller = (ViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    
    NSString * message = [NSString stringWithCString:text.utf8().get_data() encoding:NSUTF8StringEncoding];
    NSString * imagePath = [NSString stringWithCString:path.utf8().get_data() encoding:NSUTF8StringEncoding];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [root_controller presentViewController:avc animated:YES completion:nil];
}



void GodotShare::_bind_methods() {
#if VERSION_MAJOR == 3
    ClassDB::bind_method(D_METHOD("shareText"), &GodotShare::shareText);
    ClassDB::bind_method(D_METHOD("sharePic"), &GodotShare::sharePic);
#else
    ObjectTypeDB::bind_method("shareText", &GodotShare::shareText);
    ObjectTypeDB::bind_method("sharePic", &GodotShare::sharePic);
#endif
    
}
