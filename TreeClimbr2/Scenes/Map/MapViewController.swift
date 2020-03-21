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
    
}

class MapViewController: UIViewController, MapDisplayLogic, CLLocationManagerDelegate
{
    
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var treeListButton: UIButton!
    @IBOutlet weak var addTreeToLocationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    var userCoordinate = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapViewWillStartLoadingMap(self.mapView)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {

    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView)
    {

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        userCoordinate = myLocation
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()
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
