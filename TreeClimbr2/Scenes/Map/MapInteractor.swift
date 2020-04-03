//  MapInteractor.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit
import CoreLocation

protocol MapBusinessLogic
{
    func getUserRegion(request: Map.CenterToUser.Request)
    func getTrees()
}

protocol MapDataStore
{
    var treesArr: [Tree] { get set }
}

class MapInteractor: MapBusinessLogic, MapDataStore
{
    
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    var locationWorker: LocationWorker? = {
        let locationWorker = LocationWorker()
        return locationWorker
    }()
    
    var treesArr: [Tree] = [Tree]()
    
    func getUserRegion(request: Map.CenterToUser.Request)
    {
        let region = locationWorker?.userRegion(location: request.userLocation)
        let response = Map.CenterToUser.Response(region: region!)
        presenter?.presentUserRegion(response: response)
    }
    
    func getTrees()
    {
        TreeWorker.read(completion: { trees in
            let response = Map.ReadTrees.Response(treeArr: trees!)
            self.presenter?.presentTreeAnnotations(response: response)
        })
    }
}
