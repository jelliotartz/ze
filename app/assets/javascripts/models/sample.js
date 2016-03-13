function Sample(sample_details) {
  this.name = sample_details["name"];
  this.description = sample_details["description"];
  this.content = sample_details["content"];
  this.user_id = sample_details["user_id"];
  this.group_id = sample_details["group_id"];
  this.keywords = [];
}

Sample.prototype.addKeyword = function(keyword) {
  this.keywords.push(keyword)
}

Sample.prototype.addKeywords = function(keywords) {
  var that = this;
  keywords.forEach(function(keyword) {
    that.keywords.push(keyword);
  });
}
