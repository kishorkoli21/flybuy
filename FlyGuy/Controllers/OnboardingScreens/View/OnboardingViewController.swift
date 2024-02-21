//
//  OnboardingViewController.swift
//  FlyGuy
//
//  Created by Mac on 14/03/23.
//

import UIKit

class OnboardingViewController: BaseViewController {

    @IBOutlet weak var onboardingCollcetionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            self.pageControl.currentPage = self.currentPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        onboardingCollcetionView.delegate = self
        onboardingCollcetionView.dataSource = self
        
        slides = [OnboardingSlide(title: Messages.onboardingTitle1, description: Messages.onboardingDesc1, image: #imageLiteral(resourceName: "onboardingImage1")),OnboardingSlide(title: Messages.onboardingTitle2, description: Messages.onboardingDesc2, image: #imageLiteral(resourceName: "onboardingImage2")),OnboardingSlide(title: Messages.onboardingTitle3, description: Messages.onboardingDesc3, image: #imageLiteral(resourceName: "onboardingImage3"))]
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if UIDevice.current.userInterfaceIdiom == .phone{
            if currentPage == slides.count - 1{
                moveToTabBar()
            }else{
                currentPage += 1
                let indexpath = IndexPath(item: currentPage, section: 0)
                onboardingCollcetionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            }
        }else{
            if currentPage == slides.count - 1{
                //moveToHomeVCiPad()
                moveToMainContaineripadVC()
            }else{
                currentPage += 1
                let indexpath = IndexPath(item: currentPage, section: 0)
                onboardingCollcetionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            }
        }

    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
     func moveToMainContaineripadVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MainiPadContanerStoryboard, bundle:nil)
        let MainContaineriPadVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MainiPadContainerViewController) as! MainiPadContainerViewController
        MainContaineriPadVC.isFromipadOnboarding = true
        MainContaineriPadVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(MainContaineriPadVC, animated: true)
    }

}

extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardingCollcetionView.dequeueReusableCell(withReuseIdentifier: Cells.OnboardingCollectionViewCell, for: indexPath) as! OnboardingCollectionViewCell
        cell.setUp(slide: slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.onboardingCollcetionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width

        self.currentPage = Int(scrollView.contentOffset.x / width)
        self.pageControl.currentPage = self.currentPage

        if(self.currentPage == 2){

        }else{

        }
    }
    
}
