import UIKit

class SecondScreenViewController: UIViewController {
    var selectedRoom: String?

    @IBOutlet weak var contentView: SecondGradientView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var Roomtitle: UILabel!
    @IBOutlet weak var RoomView: UIImageView!
    
    @IBAction func customBackButton1Tapped(_ sender: UIButton) {
           navigationController?.popViewController(animated: true)
       }
    
    var devices: [Device] = [
        Device(name: "Air Conditioner", subtitle: "Samsung AR9500T", icon: "wind", status: "20°C", isOn: true),
        Device(name: "Smart Light", subtitle: "Mi Smart LED Ceiling Light", icon: "bulb", status: "92%", isOn: true),
        Device(name: "Vacuum Cleaner", subtitle: "Xiaomi CDZC108", icon: "vacuum-cleaner", status: "43%", isOn: false),
        Device(name: "Vacuum Cleaner", subtitle: "Xiaomi CDZC108", icon: "vacuum", status: "43%", isOn: false)
    ]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                    
                    navigationController?.setNavigationBarHidden(true, animated: false)
                    self.extendedLayoutIncludesOpaqueBars = true
                    view.backgroundColor = .clear
                
        // 🔹 Set room title & image
        if let room = selectedRoom {
            Roomtitle.text = room
            switch room {
            case "Living Room":
                RoomView.image = UIImage(named: "living Room")
            case "Kitchen":
                RoomView.image = UIImage(named: "Kitchen")
            case "Bedroom":
                RoomView.image = UIImage(named: "bedroom")
            case "Balcony":
                RoomView.image = UIImage(named: "balcony")
            case "Dining":
                RoomView.image = UIImage(named: "dining")
            case "Bathroom":
                RoomView.image = UIImage(named: "bathroom")
            case "Study":
                RoomView.image = UIImage(named: "Study")
            default:
                RoomView.image = UIImage(named: "defaultRoom")
            }
        }
        
        // 🔹 ScrollView size (only if NOT using Auto Layout properly)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1200)

        gradientContainer.backgroundColor = .clear
        collectionView.backgroundColor = .clear

        // 🔹 CollectionView setup
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
    }
    
    // 🔹 Refresh layout on device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension SecondScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceCollectionCell", for: indexPath) as! DeviceCollectionCell
        
        var device = devices[indexPath.item]
        cell.configure(with: device)
        
        // Toggle action
        cell.toggleAction = { [weak self] in
            guard let self = self else { return }
            device.isOn.toggle()
            self.devices[indexPath.item] = device
            self.collectionView.reloadItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let device = devices[indexPath.item]
        goToDeviceDetail(title: device.name, subtitle: device.subtitle)
    }

    
    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 16
        let availableWidth = collectionView.bounds.width - (padding * 2)
        
        return CGSize(width: availableWidth, height: 130)
    }
}
