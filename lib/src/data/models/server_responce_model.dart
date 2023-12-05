class ServerResponseModel {
  final String flag;
  final String url;
  final String ip;

  ServerResponseModel(this.flag, this.url, this.ip);

  ServerResponseModel.fromJson(Map<String, dynamic> json)
      : flag = json['flag'],
        url = json['url'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'url': url,
        'ip': ip,
      };
}
