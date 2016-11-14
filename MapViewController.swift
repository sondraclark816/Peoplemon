import UIKit
import MapKit
import MBProgressHUD
import CoreLocation
import Alamofire

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var updateLocation = true
    var annotations: [MapPin] = []
    var latitudeDelta = 0.005
    var longitudeDelta = 0.005
    
    var overlay: MKAnnotation?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.distanceFilter = kCLDistanceFilterNone
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
        loadNearbyPeople()
        
        print("Made it do view did load and through loadNearbyPeople")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) //listen for notification/ says successfully logged in.
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
            
        } else {
            startTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { //stop listening 
        stopTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(checkinTapped(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    
    
    func loadNearbyPeople (){
        let nearbyPerson = User(radiusInMeters: 100)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin, let people = mapPin.user, let name = people.userName, let userId = people.userId {
            let alert = UIAlertController(title: "Catch", message: "\(name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Catch", style: .default, handler: { (action) in
                let catchPeople = User(caughtUserId: userId, radiusInMeters: 100)
                WebServices.shared.postObject(catchPeople, completion: { (object, error) in
                    if let error = error{
                        self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                    } else{
                        self.present(Utils.createAlert("Nice!", message: "You've caught \(name)!"), animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
            pinView!.animatesDrop = false
            
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    
    //MARK: Private Functions
    fileprivate func archiveFilePath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //Makes a path directly to the file in an array of strings
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("CaughtStore.plist")
        return path
    }
}
