//
//  AlertMasterService.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

public class AlertMasterService {
    
    var components: [AlertComponents]
    var buttons: [AlertActionButton]
    
    #warning("add to config")
    /*
     var isShowCloseButton: Bool
     var backgroundImage: UIImage?
     */
    
    public init(
        components: [AlertComponents],
        buttons: [AlertActionButton]
    ) {
        self.components = components
        self.buttons = buttons
    }
}
