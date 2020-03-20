//
//  TreeAnnotation.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import UIKit
import MapKit

class TreeAnnotation: NSObject, MKAnnotation
{
    var coordinate = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
    var tree : Tree!
}
