//
//  UITestLaunchArgument.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

enum UITestLaunchArguments: String {
    case rootLoader       = "--uitest_root_loader"
    case rootNoContent    = "--uitest_root_no_content"
    case rootSuccess      = "--uitest_root_success"
    
    case sectionLoader    = "--uitest_section_loader"
    case sectionNoContent = "--uitest_section_no_content"
    case sectionSuccess   = "--utest_section_success"
    
    case listNavigationToSection   = "--uitest_list_navigation_to_section"
    case listNavigationToRoot      = "--uitest_list_navigation_to_root"
    
}
