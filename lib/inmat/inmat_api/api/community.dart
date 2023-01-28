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

  ///게시글 작성 API
  Future<void> writePost(
      {required String title, required String content}) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "게시글 작성",
      url: "/communities",
      body: {
        "contents": content,
        "topic": title,
      },
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
