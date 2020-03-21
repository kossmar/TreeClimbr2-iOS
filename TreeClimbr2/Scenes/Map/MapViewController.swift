//
//  MapViewController.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright (c) 2020 Mar Koss. All rights reserved.


import UIKit
import MapKit
import CoreLocation
import Firebase

protocol MapDisplayLogic: class
{
    func displayUserRegion(viewModel: Map.CenterToUser.ViewModel)
    func displayTreeAnnotations(viewModel: Map.ReadTrees.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic
{
    
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var treeListButton: UIButton!
    @IBOutlet weak var addTreeToLocationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    var userCoordinate = CLLocationCoordinate2D()
    var locationManager = LocationWorker()
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(onDidUpdateLocation(_:)), name: Notification.Name.didUpdateLocation, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.mapView.removeAnnotations(self.mapView.annotations)
        getTrees()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        AppUtility.lockOrientation(.all)
        //TODO: What is this doing?
//        guard let someHandle = handle else {return}
//        Auth.auth().removeStateDidChangeListener(someHandle)

    }
    
    func getTrees()
    {
        interactor?.getTrees()
    }
    
    func displayTreeAnnotations(viewModel: Map.ReadTrees.ViewModel)
    {
        mapView.addAnnotations(viewModel.treeAnnotationArr)
    }
    
    
    @objc func onDidUpdateLocation(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String:MKCoordinateRegion]
        {
            for (_, region) in data
            {
                mapView.setRegion(region, animated: true)
                mapView.showsUserLocation = true
            }
        }
    }

    @IBAction func centerToUser(_ sender: Any)
    {
        let request = Map.CenterToUser.Request(userLocation: mapView.userLocation)
        interactor?.getUserRegion(request: request)
    }
    
    func displayUserRegion(viewModel: Map.CenterToUser.ViewModel)
    {
        self.mapView.setRegion(viewModel.region, animated: true)
        self.mapView.userTrackingMode = .follow
    }
}


extension MapViewController: MKMapViewDelegate
{
    
}

extension MapViewController: MapFocusDelegate
{
    func focusOnTree(location: CLLocationCoordinate2D, tree: Tree)
    {
        
    }
}

protocol MapFocusDelegate
{
    func focusOnTree(location: CLLocationCoordinate2D, tree: Tree)
}
