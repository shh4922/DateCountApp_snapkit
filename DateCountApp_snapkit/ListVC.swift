import SnapKit
import SwiftUI
import UIKit

class ListVC: UIViewController {
    private let titleLabel = UILabel()
    private var text1 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    
    private func setLayout(){
        view.backgroundColor = .brown
        view.addSubview(titleLabel)
        view.addSubview(text1)
        
        titleLabel.text = "오늘의 글귀"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalToSuperview().offset(30)
        }
        text1.text = "뭉치면 살고 흩어지면 죽는다. 하지만 나는 너무 배가고프다 그렇기떄문에 밥을 먹어야한다. 슈바암ㅇㄴ암ㄴ이ㅏㅓㅁㄴ이ㅏㅁㄴㄴ머 \n asdasd asdasdas\n asdasd 뭉치면 살고 흩어지면 죽는다. 하지만 나는 너무 배가고프다 그렇기떄문에 밥을 먹어야한다"
        text1.textColor = .black
        text1.numberOfLines = .zero
        text1.textAlignment = .center
//        text1.font = UIFont(name: "KCC-Chassam", size: 20)
        text1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
    }

}



#if DEBUG
struct ListView: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ListVC()
    }
}
@available(iOS 13.0, *)
struct ListView_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            ListView()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
