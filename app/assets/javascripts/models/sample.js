function Sample(sample_details) {
  this.id = sample_details["id"];
  this.name = sample_details["name"];
  this.description = sample_details["description"];
  this.content = sample_details["content"];
  this.user_id = sample_details["user_id"];
  this.created_at = sample_details["created_at"];
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

Sample.prototype.calculateAverages = function() {
  if (this.keywords.length == 0) {
    return "No averages";
  } else {
    var averages = {};
    var that = this;
    var genderCount = function(gender) {
      return that.keywords.filter(function(keyword){
        return keyword.gender === gender;
      }).length
    }
    this.keywords.forEach(function(keyword) {
      averages[keyword.gender] = keyword.sentiment_score + (averages[keyword.gender] || 0);
    })
    for (var gender in averages) {
      averages[gender] /= genderCount(gender);
    }
    return averages;
  }
}

Sample.prototype.genderedKeywords = function() {
  return this.keywords.filter(function(keyword) {
    return keyword.gender !== "neutral";
  });
}
