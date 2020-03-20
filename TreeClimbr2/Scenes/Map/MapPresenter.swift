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
  func presentSomething(response: Map.Something.Response)
}

class MapPresenter: MapPresentationLogic
{
  weak var viewController: MapDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Map.Something.Response)
  {
    let viewModel = Map.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
