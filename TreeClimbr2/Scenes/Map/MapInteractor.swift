//  MapInteractor.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit
import CoreLocation

protocol MapBusinessLogic
{
    func getUserLocation(request: Map.CenterToUser.Request)
}

protocol MapDataStore
{
    
}

class MapInteractor: MapBusinessLogic, MapDataStore
{
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    var locationWorker: LocationWorker? = {
        let locationWorker = LocationWorker()
        return locationWorker
    }()
    
    func getUserLocation(request: Map.CenterToUser.Request)
    {
        let region = locationWorker?.centerToUser(location: request.userLocation)
        let response = Map.CenterToUser.Response(region: region!)
        presenter?.presentUserLocation(response: response)
    }
}
