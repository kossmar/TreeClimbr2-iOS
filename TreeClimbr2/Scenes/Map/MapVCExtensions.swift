//
//  MapVCExtensions.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-21.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is TreeAnnotation)
        {
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation")
        if annView == nil
        {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
            annView!.canShowCallout = true
            let detailButton: UIButton = UIButton(type: UIButton.ButtonType.detailDisclosure) as UIButton
            annView!.rightCalloutAccessoryView = detailButton
        } else {
            annView!.annotation = annotation
        }
        
        annView!.image = #imageLiteral(resourceName: "CustomAnnotation")
        let size = annView!.image!.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, hasAlpha, scale)
        annView!.image!.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        annView!.image = scaledImage
        return annView!
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if control == view.rightCalloutAccessoryView
        {
            let cusView = view.annotation as! TreeAnnotation
            let treeObject = cusView.tree
            performSegue(withIdentifier: "toTreeDetail", sender: treeObject)
        }
    }
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
