import UIKit

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var SmartTVView: UIView!
    
    @IBOutlet var gradientContainer: GradientView!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var scenesCollectionView: UICollectionView!
    @IBOutlet weak var devicesCollectionView: UICollectionView!
    @IBOutlet weak var toggleBackground: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    private var toggler: Toogler!
    
    @IBAction func mainToggleTapped(_ sender: UIButton) {
        toggler.toggle()
    }
    
    let tabs = ["Living Room", "Kitchen", "Bedroom", "Balcony", "Dining", "Bathroom", "Study"]
    var selectedIndex = 0
    // Scenes
    let scenes: [(title: String, icon: String)] = [
        ("Awakening", "sun.max"),
        ("Night", "moon"),
        ("Calm", "drop"),
        ("Energetic", "bolt")
    ]
    var selectedSceneIndex = 0
    
    var devices: [Device] = [
        Device(name: "Air Conditioner", subtitle: "Samsung AR95OOT", icon: "wind",
               status: "20°C", isOn: false),
        
        Device(name: "Smart Light", subtitle: "Mi LED Light", icon: "lightbulb",
               status: "92%", isOn: false),
        
        Device(name: "Smart TV", subtitle: "Sony Bravia 55\"", icon: "tv",
               status: "55%", isOn: true)
    ]
    var selectedDeviceIndex = 0   // 🔹 Added this

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on this first screen
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
     
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(SmartTVTapped))
            SmartTVView.addGestureRecognizer(tap)
            SmartTVView.isUserInteractionEnabled = true
        toggler = Toogler(toggleBackground: toggleBackground, toggleButton: toggleButton)
        toggler.onToggle = { isOn in
            print("Main toggle state:", isOn)
            
            
            
            
        }
    
        // Tabs setup
        if let layout = tabsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.sectionInset = .zero
        }
        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        tabsCollectionView.backgroundColor = .clear
        tabsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TabCell")
        
        // Scenes setup
        if let layout = scenesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.sectionInset = .zero
        }
        scenesCollectionView.delegate = self
        scenesCollectionView.dataSource = self
        scenesCollectionView.backgroundColor = .white.withAlphaComponent(0.6)
        scenesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SceneCell")
        
        // Devices setup
        if let layout = devicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        devicesCollectionView.delegate = self
        devicesCollectionView.dataSource = self
        devicesCollectionView.backgroundColor = .clear
    }
    @objc func SmartTVTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let thirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdScreenViewController") as? ThirdScreenViewController {
            
            // Pass the data for title and subtitle
            thirdVC.deviceTitle = "Smart TV"
            thirdVC.deviceSubtitle = "Samsung AR95OOT"

            self.navigationController?.pushViewController(thirdVC, animated: true)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = tabs[indexPath.item]
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textAlignment = .center
            
            if selectedIndex == indexPath.item {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                label.textColor = .black
            } else {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
                label.textColor = .darkGray
            }
            
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
            return cell
            
        } else if collectionView == scenesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SceneCell", for: indexPath)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let scene = scenes[indexPath.item]
            
            let circleView = UIView()
            circleView.translatesAutoresizingMaskIntoConstraints = false
            circleView.layer.cornerRadius = 35
            circleView.clipsToBounds = true
            circleView.backgroundColor = indexPath.item == selectedSceneIndex ? .white : UIColor.gray.withAlphaComponent(0.2)
            
            let imageView = UIImageView(image: UIImage(systemName: scene.icon))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = indexPath.item == selectedSceneIndex ? .black : .black.withAlphaComponent(0.6)
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = scene.title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .center
            label.textColor = indexPath.item == selectedSceneIndex ? .black : .gray
            
            cell.contentView.addSubview(circleView)
            circleView.addSubview(imageView)
            cell.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                circleView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                circleView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                circleView.widthAnchor.constraint(equalToConstant: 70),
                circleView.heightAnchor.constraint(equalToConstant: 70),
                
                imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 28),
                imageView.heightAnchor.constraint(equalToConstant: 28),
                
                label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 6),
                label.centerXAnchor.constraint(equalTo: circleView.centerXAnchor)
            ])
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeviceCell.identifier, for: indexPath) as! DeviceCell
            cell.configure(with: devices[indexPath.item])
            
            // 🔹 Selection UI logic for devices
            if indexPath.item == selectedDeviceIndex {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            } else {
                cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            }
            
            return cell
        }
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
            // ✅ NEW: update selectedSceneIndex and reload
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


// MARK: - Gradient View
class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 242/255, green: 212/255, blue: 176/255, alpha: 1).cgColor,
            UIColor(red: 246/255, green: 226/255, blue: 240/255, alpha: 1).cgColor,
            UIColor(red: 158/255, green: 203/255, blue: 213/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
