import 'package:shelf/data/model/home/book_detail_data.dart';

class HistoryBook {
  final Book book;
  final double readingProgress;

  const HistoryBook({
    required this.book,
    required this.readingProgress,
  });
}

class BookOfTheDay {
  final String imagePath;
  final String title;
  final String author;
  final String description;

  BookOfTheDay({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.description,
  });
}

class BestsellerBook {
  final String imagePath;
  final String title;
  final String author;
  final String rank;

  BestsellerBook({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.rank,
  });
}

final List<HistoryBook> historyBooks = [
  HistoryBook(book: newBooks[0], readingProgress: 0.7),
  HistoryBook(book: newBooks[1], readingProgress: 0.8),
];

final bookOfTheDay = BookOfTheDay(
  imagePath: 'assets/images/book1.png',
  title: '책제목',
  author: '작가 이름',
  description: '책 소개 내용.',
);

final List<BestsellerBook> bestsellerBooks = [
  BestsellerBook(
    imagePath: 'assets/images/book1.png',
    title: '퀀의 대각선 1',
    author: '베르나르 베르베르',
    rank: '1',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book2.png',
    title: '리틀 라이프',
    author: '마티아스 볼케',
    rank: '2',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book3.png',
    title: '부의 추월차선',
    author: '한야 야나기하라',
    rank: '3',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book4.png',
    title: '마흔에 읽는...',
    author: 'Disney Books',
    rank: '4',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book5.png',
    title: '초월 부처의..,',
    author: '밀리의 서재',
    rank: '5',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book6.png',
    title: '[독점] 당신도 논리...',
    author: '코이케 류노스케',
    rank: '6',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book7.png',
    title: '[독점] 당신도 논리...',
    author: '오시마 도모히데',
    rank: '7',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book8.png',
    title: '마흔에 읽는 쇼펜하우...',
    author: '강용수',
    rank: '8',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book9.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '9',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book10.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '10',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book1.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '11',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book9.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '12',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book10.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '13',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book1.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '14',
  ),
  BestsellerBook(
    imagePath: 'assets/images/book9.png',
    title: '이처럼 사소한 것들',
    author: '클레어 키건',
    rank: '15',
  ),
];

class RankBook {
  final String title;
  final String author;
  final String category;
  final int rank;
  final String imagePath;

  RankBook(this.title, this.author, this.category, this.rank, this.imagePath);
}

List<RankBook> dummyBooks = [
  RankBook('퀸의 대각선', '윤정훈', '자기계발', 1, 'assets/images/book1.png'),
  RankBook('리틀 라이프', '대니얼 키스', '소설', 2, 'assets/images/book2.png'),
  RankBook('부의 추월차선', '엠제이 드마코', '경제/경영', 3, 'assets/images/book3.png'),
  RankBook('마흔에 읽는 쇼펜하우어', '김윤나', '자기계발', 4, 'assets/images/book4.png'),
  RankBook('초월 부처의 삶', '빅터 프랭클', '인문/교양', 5, 'assets/images/book5.png'),
  RankBook('이처럼 사소한 것들', '기시미 이치로', '자기계발', 6, 'assets/images/book6.png'),
  RankBook('어떻게 살 것인가', '유시민', '인문/교양', 7, 'assets/images/book7.png'),
  RankBook('설민석의 한국사 대모험', '설민석', '소설', 8, 'assets/images/book8.png'),
  RankBook('아몬드', '손원평', '소설', 9, 'assets/images/book9.png'),
  RankBook('돈의 속성', '김승호', '경제/경영', 10, 'assets/images/book10.png'),
  RankBook('하버드 상위 1퍼센트의 비밀', '정주영', '자기계발', 11, 'assets/images/book11.png'),
  RankBook('역사의 쓸모', '최태성', '인문/교양', 12, 'assets/images/book12.png'),
  RankBook('나는 나로 살기로 했다', '김수현', '자기계발', 13, 'assets/images/book13.png'),
  RankBook(
      '지적 대화를 위한 넓고 얕은 지식', '채사장', '인문/교양', 14, 'assets/images/book14.png'),
  RankBook('82년생 김지영', '조남주', '소설', 15, 'assets/images/book15.png'),
  RankBook('트렌드 코리아 2022', '김난도', '경제/경영', 16, 'assets/images/book16.png'),
  RankBook('역사란 무엇인가', '에드워드 카', '인문/교양', 17, 'assets/images/book17.png'),
  RankBook('자존감 수업', '윤홍균', '자기계발', 18, 'assets/images/book18.png'),
  RankBook(
      '무례한 사람에게 웃으며 대처하는 법', '정문정', '자기계발', 19, 'assets/images/book19.png'),
  RankBook('공부머리 독서법', '최승필', '자기계발', 20, 'assets/images/book20.png'),
];
