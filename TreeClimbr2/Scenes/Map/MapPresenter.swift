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
    func presentUserRegion(response: Map.CenterToUser.Response)
    func presentTreeAnnotations(response: Map.ReadTrees.Response)
}

class MapPresenter: MapPresentationLogic
{
    
    weak var viewController: MapDisplayLogic?
    
    func presentUserRegion(response: Map.CenterToUser.Response)
    {
        let viewModel = Map.CenterToUser.ViewModel(region: response.region)
        viewController?.displayUserRegion(viewModel: viewModel)
    }
    
    func presentTreeAnnotations(response: Map.ReadTrees.Response)
    {
        let viewModel = Map.ReadTrees.ViewModel(treeAnnotationArr: response.treeAnnotationArr)
        viewController?.displayTreeAnnotations(viewModel: viewModel)
    }
}
