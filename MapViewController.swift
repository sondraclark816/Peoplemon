import UIKit
import MapKit
import MBProgressHUD
import CoreLocation
import SafariServices

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var updateLocation = true
    var annotations: [MapPin] = []
    var latitudeDelta = 0.005
    var longitudeDelta = 0.005
    
//    var nearbyPeople = [User]()
    var overlay: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.locationManager.delegate = self
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
        loadNearbyPeople()
        
        print("Make it do view did load and through loadNearbyPeople")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
            
        }
    }
    
    
    
    
    
    func loadNearbyPeople (){
        let nearbyPerson = User(radiusInMeters: 500.0)
        
       
                WebServices.shared.getObjects(nearbyPerson) { (objects, errors) in
                    if let objects = objects {
                        let oldannotations = self.annotations
                        self.annotations = []
                        for user in objects {
                            let pin = MapPin(user: user)
                            self.annotations.append(pin)
                        }
                        self.mapView.addAnnotations(self.annotations)
                        self.mapView.removeAnnotations(oldannotations)
                    }
                }
            }
    

    //Mark - @IBActions
    @IBAction func logoutTapped(_ sender: Any) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }
        
    }
    @IBAction func checkinTapped(_ sender: Any) {
        if let location = locationManager.location {
            let people = User(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            WebServices.shared.postObject(people, completion: { (person, error) in
                if let error = error {
                    self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                }else {
                    self.present(Utils.createAlert("User", message: "You are officially checked in."), animated: true, completion: nil)
                }
            })
        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(latitudeDelta, longitudeDelta))
        mapView.setRegion(region, animated: true)
        updateLocation = false
        locationManager.stopUpdatingLocation()
        
//        let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 100, 100)
//        self.mapView.setRegion(myArea, animated: true)
        
        
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView?.isEnabled = true
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
}
