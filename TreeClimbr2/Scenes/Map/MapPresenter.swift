//
//  MapPresenter.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.
//

import UIKit

protocol MapPresentationLogic
{
    func presentUserLocation(response: Map.CenterToUser.Response)
}

class MapPresenter: MapPresentationLogic
{
    
    weak var viewController: MapDisplayLogic?
    
    func presentUserLocation(response: Map.CenterToUser.Response)
    {
        let viewModel = Map.CenterToUser.ViewModel(region: response.region)
        
    }
    
}
