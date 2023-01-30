part of '../inmat_api.dart';

class CommunityApi {
  Future<List<Map>> getIdeas() async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "전체 아이디어 불러오기",
      url: "/trade/",
      // token: InMatAuth.instance?.currentUser?.token,
    );
    return (await inMatHttp.execute()).cast<Map>();
  }

  Future<Map> getIdea(int id) async {
    print("dsadas: $id");
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "특정 아이디어 불러오기",
      url: "/trade/$id",
      // token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  Future<Map> getReview(int id) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "특정 게시물에 적힌 리뷰 목록 불러오기",
      url: "/review/get/$id",
      // token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  Future<void> writePost({
    required int user_id,
    required String title,
    required String overview,
    required String description,
    required int price,
    required int category,
    required String thumbnail,
    required bool is_commercial_available,
    required bool is_patent_available,
  }) async {
    print({
      "user_id": user_id,
      "title": title,
      "overview": overview,
      "description": description,
      "price": price,
      "category": category,
      "thumbnail": thumbnail,
      "is_commercial_available": is_commercial_available,
      "is_patent_available": is_patent_available
    });
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "게시글 작성",
      url: "/idea/create",
      body: {
        "title": title,
        "overview": overview,
        "description": description,
        "price": price,
        "category": category,
        "thumbnail": thumbnail,
        "is_commercial_available": is_commercial_available,
        "is_patent_available": is_patent_available
      },
      token: user_id.toString(),
    );
    return await inMatHttp.execute();
  }

  Future<String> getImageUrl(String name) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "이미지 url 불러오기",
      url: "/upload/$name",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  Future<void> setBookMark(int index) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "북마크 설정",
      url: "/collection/add",
      body: {"idea_id": index},
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  Future<void> deleteBookMark(int index) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "북마크 취소",
      url: "/collection/delete",
      body: {"idea_id": index},
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  Future<List> getMail(int user_id) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "쪽지 가져오기",
      url: "/mail/get/$user_id",
      token: user_id.toString(),
    );
    return await inMatHttp.execute();
  }




  /// 이 밑으로는 추가 안함

  // /review/get

  ///커뮤니티 조회 API
  Future<List<Map>> getPosts() async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "커뮤니티 불러오기",
      url: "/communities",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return (await inMatHttp.execute()).cast<Map>();
  }

  ///특정 게시물 조회 API
  Future<Map<String, dynamic>> getPost(int id) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "게시물 불러오기",
      url: "/communities/$id",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  ///게시글 삭제 API
  Future<void> deletePost(int postId) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.patch,
      message: "게시글 삭제",
      url: "/communities/$postId/delete",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  ///댓글 작성 API
  Future<void> writeComment(int id, String comment) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "댓글 쓰기",
      url: "/communities/$id/details/comment",
      body: {
        "contents": comment,
      },
      token: InMatAuth.instance?.currentUser?.token,
    );
    var v = await inMatHttp.execute();
    print(v);

    /// ToDo 댓글쓰고 리턴값 받아야함

    return;
  }

  ///게시글 좋아요 API
  Future<void> setHeart(int postId) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "게시글 하트 설정",
      url: "/communities/$postId/details/like",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }

  ///게시글 좋아요 API
  Future<void> deleteHeart(int postId) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.patch,
      message: "게시글 하트 취소",
      url: "/communities/$postId/details/like/delete",
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }
}
