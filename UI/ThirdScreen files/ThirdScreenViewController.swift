import UIKit



class ThirdScreenViewController: UIViewController {
    
    var deviceTitle: String?
    var deviceSubtitle: String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    @IBOutlet weak var scheduleView: UIView!
    
    
    @IBOutlet weak var scheduleView2: UIView!
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    
    @IBOutlet var gradientContainer: CustomGradientView!
    @IBOutlet weak var temperatureView: TemperatureCircleView!
    @IBOutlet weak var modesCollectionView: UICollectionView!
    @IBAction func customBackButtonTapped(_ sender: UIButton) {
           navigationController?.popViewController(animated: true)
       }
    let options: [(title: String, icon: String)] = [
            ("Switch Off", "power"),
            ("Settings", "gearshape")
        ]
    
    // Modes data - Using the same circular design as scenes
    let modes: [(title: String, icon: String)] = [
        ("Hot", "sun.max"),
        ("Cold", "snowflake"),
        ("Dry Air", "wind"),
        ("Humid", "drop")
    ]
    var selectedModeIndex = 1 // Default to Cold
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.extendedLayoutIncludesOpaqueBars = true
        setupModesCollectionView()
        setupTemperatureView()
        setupOptionsCollectionView()
        // First view border
            scheduleView.layer.borderWidth = 1
        scheduleView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
            scheduleView.layer.cornerRadius = 20
            scheduleView.clipsToBounds = true
            
            // Second view border
        scheduleView2.layer.borderWidth = 1
        scheduleView2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor

            scheduleView2.layer.cornerRadius = 20
            scheduleView2.clipsToBounds = true
        self.title = deviceTitle
           titleLabel.text = deviceTitle
           subtitleLabel.text = deviceSubtitle
        
        
        
        
    }
    
    private func setupTemperatureView() {
        temperatureView.minTemperature = 15
        temperatureView.maxTemperature = 32
        temperatureView.temperature = 22
        
        // Set up button actions
        temperatureView.onPlusTapped = { [weak self] in
            guard let self = self else { return }
            if self.temperatureView.temperature < self.temperatureView.maxTemperature {
                UIView.animate(withDuration: 0.3) {
                    self.temperatureView.temperature += 1
                }
            }
        }
        
        temperatureView.onMinusTapped = { [weak self] in
            guard let self = self else { return }
            if self.temperatureView.temperature > self.temperatureView.minTemperature {
                UIView.animate(withDuration: 0.3) {
                    self.temperatureView.temperature -= 1
                }
            }
        }
    }
    
    private func setupModesCollectionView() {
        // Modes setup - SAME AS SCENES COLLECTION VIEW
        if let layout = modesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.sectionInset = .zero
        }
        modesCollectionView.delegate = self
        modesCollectionView.dataSource = self
        modesCollectionView.backgroundColor = .white.withAlphaComponent(0.6)
        modesCollectionView.register(ModeCollectionViewCell.self, forCellWithReuseIdentifier: "ModeCell")
    }
    private func setupOptionsCollectionView() {
        if let layout = optionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        }

        optionsCollectionView.backgroundColor = .clear
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self

       
    }
    
    private func modesNumberOfItems() -> Int {
        return modes.count
    }
    
    private func modesCellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = modesCollectionView.dequeueReusableCell(withReuseIdentifier: "ModeCell", for: indexPath) as! ModeCollectionViewCell
        let mode = modes[indexPath.item]
        cell.configure(with: mode, isSelected: indexPath.item == selectedModeIndex)
        return cell
    }
    
    private func modesSizeForItem() -> CGSize {
        let width = modesCollectionView.frame.width / 4
        return CGSize(width: width, height: 110)
    }
    
    private func modesDidSelectItem(at indexPath: IndexPath) {
        selectedModeIndex = indexPath.item
        modesCollectionView.reloadData()
        
        // Handle mode selection logic here
        let selectedMode = modes[indexPath.item]
        activateMode(selectedMode)
    }
    
    private func activateMode(_ mode: (title: String, icon: String)) {
        switch mode.title {
        case "Hot":
            print("Activating Hot mode")
        case "Cold":
            print("Activating Cold mode")
        case "Dry Air":
            print("Activating Dry Air mode")
        case "Humid":
            print("Activating Humid mode")
        default:
            break
            
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension ThirdScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Modes collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == modesCollectionView {
            return modesNumberOfItems() // call your function properly
        } else {
            return options.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == modesCollectionView {
            return modesCellForItem(at: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ControlOptionCell.identifier, for: indexPath) as! ControlOptionCell
            let option = options[indexPath.item]
            cell.configure(with: option)
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == modesCollectionView {
            modesDidSelectItem(at: indexPath)
        } else {
            let selected = options[indexPath.item].title
            if selected == "Switch Off" {
                print("Device switched off")
            } else if selected == "Settings" {
                print("Open settings")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == modesCollectionView {
            return modesSizeForItem()
        } else {
            let width = collectionView.frame.width - 20 // 10 left + 10 right insets
            let height: CGFloat = 70
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

}


// MARK: - Custom Gradient View
class CustomGradientView: UIView {
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
            UIColor(red: 158/255, green: 203/255, blue: 213/255, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
