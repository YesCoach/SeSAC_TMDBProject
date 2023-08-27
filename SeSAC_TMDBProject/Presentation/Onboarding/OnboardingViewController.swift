//
//  OnboardingViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/26.
//

import UIKit

final class OnboardingViewController: UIPageViewController {

    private lazy var firstVC: OnboardingContentViewController = {
        let viewController = OnboardingContentViewController()
        viewController.configure(with: "1", backgroundColor: .systemMint)
        return viewController
    }()

    private lazy var secondVC: OnboardingContentViewController = {
        let viewController = OnboardingContentViewController()
        viewController.configure(with: "2", backgroundColor: .systemGreen)
        return viewController
    }()

    private lazy var thirdVC: OnboardingContentViewController = {
        let viewController = OnboardingContentViewController()
        viewController.configure(with: "3", backgroundColor: .systemPurple)
        return viewController
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .systemMint
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(didStartButtonTouched), for: .touchUpInside)
        return button
    }()

    private var viewControllerList: [UIViewController] = []

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataSource = self
        delegate = self

        configureViewControllers()
        configureLayout()

        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = .lightGray
        proxy.currentPageIndicatorTintColor = .black
    }

    @objc func didStartButtonTouched(_ sender: UIButton) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: TabBarController.identifier
        ) as? TabBarController
        else { return }

        UserDefaultsManager.isLaunched = true

        sceneDelegate?.window?.rootViewController = viewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

private extension OnboardingViewController {

    func configureViewControllers() {
        viewControllerList = [firstVC, secondVC, thirdVC]
        guard let first = viewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }

    func configureLayout() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            ]
        )
    }

}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let firstIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        let prevIndex = firstIndex - 1

        return prevIndex < 0 ? nil : viewControllerList[prevIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let firstIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        print(firstIndex)
        let afterIndex = firstIndex + 1

        return afterIndex >= viewControllerList.count ? nil : viewControllerList[afterIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = viewControllerList.firstIndex(of: first)
        else { return 0 }
        return index
    }

}
