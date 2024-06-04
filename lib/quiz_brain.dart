import 'question.dart';

class QuizBrain{
  int _questionNumber = 0;


List<Question> _questionBank = [
    Question('JavaScript là ngôn ngữ lập trình.', true),
    Question('JavaScript là một phần của Java.', false),
    Question('JavaScript có thể được sử dụng trên cả client và server.', true),
    Question('JavaScript được tạo ra vào năm 1995.', true),
    Question('JavaScript chỉ có thể chạy trong trình duyệt web.', false),
    Question('JavaScript và ECMAScript là hai ngôn ngữ khác nhau.', false),
    Question('JavaScript hỗ trợ lập trình hướng đối tượng.', true),
    Question('JavaScript không thể tương tác với HTML.', false),
    Question('JavaScript không có kiểu dữ liệu.', false),
    Question('JavaScript là ngôn ngữ mạnh.', false),
];

void nextQuestion(){
  if (_questionNumber < _questionBank.length -1) {
    _questionNumber ++;
  }
}

String getQuestionText(){
  return _questionBank[_questionNumber].questionText;
}

bool getCorrectAnswer(){
  return _questionBank[_questionNumber].questionAnswer;
}

bool isFinished(){
  if(_questionNumber >= _questionBank.length -1){
    return true;
  }else {
    return false;
  }
}
void reset() {
  _questionNumber = 0;
}
}