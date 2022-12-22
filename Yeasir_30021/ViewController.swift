import UIKit

class ViewController: UIViewController {
    var movieData = ["bmx", "filmmaker", "happynewyear", "jazz", "rugby", "inception","godzilla","joker", "bmx", "filmmaker", "happynewyear", "jazz", "rugby", "inception","godzilla","joker", "bmx", "filmmaker", "happynewyear", "jazz", "rugby", "inception","godzilla","joker", "bmx", "filmmaker", "happynewyear", "jazz", "rugby", "inception","godzilla","joker","godzilla"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavItems()
        configCollectionView()
        collectionView.collectionViewLayout = listLayoutSection()
        
    }
 
    

    // grid layout
    private func gridLayoutSection() -> UICollectionViewLayout {
               
        let item1 = CollectionVL.createItem(height: .fractionalHeight(1), width: .fractionalWidth(1/2), spacing: 3)

        let horizontalGroup = CollectionVL.createGroup(height: .fractionalHeight(2/9), width: .fractionalWidth(1), alignment: .horizontal, items: [item1,item1])
        
        horizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
                let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .none
               
    
                return UICollectionViewCompositionalLayout(section: section)
        } // grid Layout
    
    // List layout
    private func listLayoutSection() -> UICollectionViewLayout {
               
        let item1 = CollectionVL.createItem(height: .fractionalHeight(1), width: .fractionalWidth(1), spacing: 3)

        let group = CollectionVL.createGroup(height: .fractionalHeight(1/2), width: .fractionalWidth(1), alignment: .horizontal, items: [item1,item1])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
        } // List Layout
    
    
    
    
    func configNavItems(){
         // nav buttons
        let listButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(listButtonPressed))
        
        let gridButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.2x2.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(gridButtonPressed))
         
        //nav title
        let navTitle = UILabel()
        navTitle.textColor = UIColor.darkGray
        navTitle.text = "Gallery"
        navTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)!
        
        //configuration
        self.navigationItem.rightBarButtonItems = [listButton, gridButton]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navTitle)
        
    } //config items
    
    @objc func gridButtonPressed() {
//        listButton.customView?.isUserInteractionEnabled = false
//        gridButton.customView?.isUserInteractionEnabled = false
        
        
        
        collectionView.startInteractiveTransition(to: gridLayoutSection()){ [weak self] _,_ in
                guard let self = self else{return}
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = true
        }
        collectionView.finishInteractiveTransition()
        print("grid layout pressed")
        
    }
    
    // list layout
    @objc func listButtonPressed() {
//        listButton.customView?.isUserInteractionEnabled = false
//        gridButton.customView?.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = false
        
        collectionView.startInteractiveTransition(to: listLayoutSection()){ [weak self] _,_ in
            guard let self = self else{return}
//            self.listButton.customView?.isUserInteractionEnabled = true
//            self.gridButton.customView?.isUserInteractionEnabled = true
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = true
        }
        
        collectionView.finishInteractiveTransition()
        print("list layout pressed")
        
    }
    
    
    
   
    
    private func configCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    } //config collectionview
    
} //view controller



extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.imageView.image = UIImage(named: movieData[indexPath.row])
        return cell
    }
    
    
} // UicollectionviewDelegate and UICollectionViewDataSource

