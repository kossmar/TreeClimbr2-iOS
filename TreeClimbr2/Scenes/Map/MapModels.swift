//
//  MapModels.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit
import MapKit

enum Map
{
    // MARK: Use cases
    
    enum CenterToUser
    {
        struct Request
        {
            let userLocation: MKUserLocation
        }
        struct Response
        {
            let region: MKCoordinateRegion
        }
        struct ViewModel
        {
            let region: MKCoordinateRegion
        }
    }
    
    enum ReadTrees
    {
        struct Request
        {
        }
        struct Response
        {
            let treeArr: [Tree]
        }
        struct ViewModel
        {
            let treeAnnotationArr: [TreeAnnotation]
        }
    }
}
