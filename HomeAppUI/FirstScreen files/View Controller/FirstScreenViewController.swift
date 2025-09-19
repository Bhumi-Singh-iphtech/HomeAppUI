import UIKit

class FirstScreenViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var SmartTVView: UIView!
    @IBOutlet var gradientContainer: GradientView!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var scenesCollectionView: UICollectionView!
    @IBOutlet weak var devicesCollectionView: UICollectionView!
    @IBOutlet weak var toggleBackground: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    private var toggler: Toogler!
    
    let tabs = ["Living Room", "Kitchen", "Bedroom", "Balcony", "Dining", "Bathroom", "Study"]
    var selectedIndex = 0
    
    let scenes: [(title: String, icon: String)] = [
        ("Awakening", "sun.max"),
        ("Night", "moon"),
        ("Calm", "drop"),
        ("Energetic", "bolt")
    ]
    var selectedSceneIndex = 0
    
    var devices: [Device] = [
        Device(name: "Air Conditioner", subtitle: "Samsung AR95OOT", icon: "wind", status: "20°C", isOn: false),
        Device(name: "Smart Light", subtitle: "Mi LED Light", icon: "lightbulb", status: "92%", isOn: false),
        Device(name: "Smart TV", subtitle: "Sony Bravia 55\"", icon: "tv", status: "55%", isOn: true)
    ]
    var selectedDeviceIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Setup SmartTV tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(SmartTVTapped))
        tap.delegate = self
        SmartTVView.addGestureRecognizer(tap)
        SmartTVView.isUserInteractionEnabled = true
        
        // Setup toggle
        toggler = Toogler(toggleBackground: toggleBackground, toggleButton: toggleButton)
        toggleButton.addTarget(self, action: #selector(mainToggleTapped(_:)), for: .touchUpInside)
        let toggleBackgroundTap = UITapGestureRecognizer(target: self, action: #selector(toggleBackgroundTapped))
        toggleBackgroundTap.delegate = self
        toggleBackground.addGestureRecognizer(toggleBackgroundTap)
        toggler.onToggle = { isOn in
            print("Main toggle state:", isOn)
        }
        
        setupCollectionViews()
    }
    
    @objc func toggleBackgroundTapped() {
        
    }

    // MARK: - Toggle actions
    @objc func mainToggleTapped(_ sender: UIButton) {
        toggler.toggle()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Prevent navigation if tap is on the toggle area
        let touchPoint = touch.location(in: self.view)
        
        if toggleBackground.frame.contains(touchPoint) {
            return false
        }
        
        return true
    }
    
    @objc func SmartTVTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let thirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdScreenViewController") as? ThirdScreenViewController {
            thirdVC.deviceTitle = "Smart TV"
            thirdVC.deviceSubtitle = "Samsung AR95OOT"
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
    }
    
    // MARK: - Setup CollectionViews
    func setupCollectionViews() {
        // Tabs
        if let layout = tabsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
        }
        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        tabsCollectionView.backgroundColor = .clear
        tabsCollectionView.register(TabCell.self, forCellWithReuseIdentifier: TabCell.identifier)
        
        // Scenes
        if let layout = scenesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        scenesCollectionView.delegate = self
        scenesCollectionView.dataSource = self
        scenesCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        scenesCollectionView.register(SceneCell.self, forCellWithReuseIdentifier: SceneCell.identifier)
        
        // Devices
        if let layout = devicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .zero
        }
        devicesCollectionView.delegate = self
        devicesCollectionView.dataSource = self
        devicesCollectionView.backgroundColor = .clear
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRoomDetail" {
            if let destinationVC = segue.destination as? SecondScreenViewController,
               let roomName = sender as? String {
                destinationVC.selectedRoom = roomName
                destinationVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    
}

// MARK: - CollectionView
extension FirstScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabsCollectionView {
            return tabs.count
        } else if collectionView == scenesCollectionView {
            return scenes.count
        } else {
            return devices.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCell.identifier, for: indexPath) as! TabCell
            cell.configure(with: tabs[indexPath.item], isSelected: selectedIndex == indexPath.item)
            return cell
            
        } else if collectionView == scenesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCell.identifier, for: indexPath) as! SceneCell
            cell.configure(with: scenes[indexPath.item], isSelected: selectedSceneIndex == indexPath.item)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeviceCell.identifier, for: indexPath) as! DeviceCell
            cell.configure(with: devices[indexPath.item])
            
            // Selection for devices collection view
            if indexPath.item == selectedDeviceIndex {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            } else {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabsCollectionView {
            selectedIndex = indexPath.item
            tabsCollectionView.reloadData()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondScreenViewController") as? SecondScreenViewController {
                secondVC.selectedRoom = tabs[indexPath.item]
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }
        
        else if collectionView == scenesCollectionView {
            // update selectedSceneIndex and reload
            selectedSceneIndex = indexPath.item
            scenesCollectionView.reloadData()
        }
        
        else if collectionView == devicesCollectionView {
            selectedDeviceIndex = indexPath.item
            devicesCollectionView.reloadData()
            
            let selectedDevice = devices[indexPath.item]
            goToDeviceDetail(title: selectedDevice.name, subtitle: selectedDevice.subtitle)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabsCollectionView {
            let text = tabs[indexPath.item]
            let font = UIFont.systemFont(ofSize: 16, weight: .medium)
            let width = (text as NSString).size(withAttributes: [.font: font]).width
            return CGSize(width: width + 40, height: 40)
        } else if collectionView == scenesCollectionView {
            let width = collectionView.frame.width / 4
            return CGSize(width: width, height: 110)
        } else if collectionView == devicesCollectionView {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpacing = layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right
            let width = (collectionView.frame.width - totalSpacing) / 2
            return CGSize(width: width, height: 200)
        }
        return CGSize(width: 100, height: 100)
    }
}
