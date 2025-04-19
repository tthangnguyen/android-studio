/*
Stream là gì?

Nếu Future giống như đợi một món ăn, thì Stream giống như xem một kênh Youtube:

Bạn đăng ký kênh (lắng nghe stream)
Video mới liên tục được đăng tải (stream phát ra dữ liệu)
Bạn xem từng video khi nó xuất hiện (xử lý dữ liệu từ stream)
Kênh có thể đăng tải nhiều video theo thời gian (stream phát nhiều giá trị)

Stream trong Dart là chuỗi các sự kiện hoặc dữ liệu theo thời gian,
không chỉ một lần như Future.

*/

import 'dart:async';

void viDuStreamDemSo(){

  print("==== Ví dụ 1: Stream trờ chời năm mười ====");

  // Tạo ra stream đém số (phát ra con số từ 0, 5, 10, ..., 100), mỗi giây đếm 1 số
  Stream<int> stream = Stream.periodic(Duration(seconds: 1), (x)=>x+5).take(21);

  // Lắng nghe
  stream.listen(
    (x) => print("Nghe được số: ${x*5} - đang chạy trốn!"),
    onDone: () => print("Người bị : bắt đầu đi tìm!"),
    onError: (loi) => print("Có vấn đề, ngưng cuộc chơi ($loi)")
  );
}

// Ví dụ 2: Tạo ddiieeud khiển stream với StreamController
void viDuStreamController() {
  print("=== Ví dụ 3: Stream Controller ===");

  // Tạo bộ điều khiển stream
  StreamController<String> controller =  StreamController<String>();
  // Lắng nghe stream
  controller.stream.listen(
    (tinNhan) => print("Tin nhắn mới: $tinNhan"),
    onDone: () => print("Không còn tin nhắn nào nữa"),
  );
 
  // Gửi tin nhắn vào stream
  print("Đang gửi tin nhắn đầu tiên...");
  controller.add("Xin chào!");
 
  // Gửi thêm tin nhắn sau 2 giây
  Future.delayed(Duration(seconds: 2), () {
    print("Đang gửi tin nhắn thứ hai...");
    controller.add("Bạn có khỏe không?");
  });

  // Gửi thêm tin nhắn sau 2 giây
  Future.delayed(Duration(seconds: 2), () {
    print("Đang gửi tin nhắn thứ hai...");
    controller.add("Bạn rất khỏe");
  });

    // Gửi thêm tin nhắn sau 2 giây
    
  Future.delayed(Duration(seconds: 2), () {
    print("Đang gửi tin nhắn thứ hai...");
    controller.add("còn bạn?");
  });

      // Gửi thêm tin nhắn sau 2 giây
  Future.delayed(Duration(seconds: 2), () {
    print("Đang gửi tin nhắn thứ hai...");
    controller.add("Mình cũng vậy");
  });

  // Gửi tin nhắn cuối và đóng stream sau 4 giây
  Future.delayed(Duration(seconds: 4), () {
    print("Đang gửi tin nhắn cuối...");
    controller.add("Tạm biệt!");
    controller.close();
  });

}
void main(){
  //viDuStreamDemSo();
  viDuStreamController();
}
