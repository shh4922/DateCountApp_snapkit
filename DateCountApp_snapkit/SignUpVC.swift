import SwiftUI
import UIKit

class SignUpVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let subLabel = UILabel()
    
    private let IdField = UITextField()
    private let passwordField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    
    
    private func setLayout(){
        self.navigationItem.title = "회원가입"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(IdField)
        contentView.addSubview(passwordField)
        
        scrollView.backgroundColor = .white
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        titleLabel.text = "회원가입"
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView).inset(0)
            make.left.equalTo(view).inset(30)
        }
        subLabel.textAlignment = .center
        subLabel.textColor = .lightGray
        subLabel.text = "회원가입후 이용해주세요."
        subLabel.font = .systemFont(ofSize: 15)
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(view).inset(30)
        }
        
    }
  
}



#if DEBUG
struct SignupView: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        SignUpVC()
    }
}
@available(iOS 13.0, *)
struct SignupView_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            SignupView()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
