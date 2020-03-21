//  MapInteractor.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit

protocol MapBusinessLogic
{
    
}

protocol MapDataStore
{
    
}

class MapInteractor: MapBusinessLogic, MapDataStore
{
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    
}
