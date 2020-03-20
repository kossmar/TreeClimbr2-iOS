//  MapInteractor.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit

protocol MapBusinessLogic
{
    func doSomething(request: Map.Something.Request)
}

protocol MapDataStore
{
    
}

class MapInteractor: MapBusinessLogic, MapDataStore
{
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Map.Something.Request)
    {
        worker = MapWorker()
        worker?.doSomeWork()
        
        let response = Map.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
