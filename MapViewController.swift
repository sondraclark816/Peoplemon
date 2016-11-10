import UIKit
import MapKit
import MBProgressHUD
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var updateLocation = 0
    
    var nearbyPeople = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
            
            
        }else{
            self .locationManager.requestWhenInUseAuthorization()
        }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        
        let initialLocation = CLLocation(latitude: 37.8165, longitude: -82.8085)
        
        let regionRadius: CLLocationDistance = 100
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
        
        func loadNearbyPeople (){
            let nearbyPerson = User(radiusInMeters: Constants.radius)
            
            WebServices.shared.getObjects(nearbyPerson) { (everyoneNearby, error) in
                if let everyoneNearby = everyoneNearby {
                    self.nearbyPeople = everyoneNearby
                    
                    
                }
            }
        }
        
        
        func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
            
            
            let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 1000, 1000)
            self.mapView.setRegion(myArea, animated: true)
            
        }
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
