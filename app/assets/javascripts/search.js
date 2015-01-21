$(document).ready(function(){
  var profiles = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
    remote: {
      url: '/search/query?q=%QUERY'
       ,
       filter: function(results){
            return results.user;
        },
        cache: false
         }
    });
    
    var skills = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
    remote: {
      url: '/search/query?q=%QUERY'
       ,
       filter: function(results){
       console.log(results.skill);
            return results.skill;
        },
        cache: false
         }
    }); 
    
  skills.initialize();
  profiles.initialize();
  
  var templ =  Hogan.compile([
    '<div class="container nopadding">',
    '<div class="row">',
    '<div class="col-md-2">',
    '<a href="/users/{{id}}">' ,'<img class="picture-cover" src="/assets/{{avatar}}" /></img>',
    '</div>',
    '<div class="col-md-10">',
    '{{name}}',
    '</a>',
    '<p>{{city}}</p>',
    '</div>',
    '</div>'].join(''));
    
  var templskill = Hogan.compile([
    '<div class="container nopadding">',
    '<div class="row">',
    '<div class="col-md-2">',
    '<a href="/skills/{{sid}}">' ,'<img class="picture-cover" src="/assets/{{skillimage}}" /></img>',
    '</div>',
    '<div class="col-md-10">',
    '{{sname}}',
    '</a>',
    '<p>by {{tname}}</p>',
    '</div>',
    '</div>'].join(''));

  $('.mainsearch .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
},
{
  name: 'profile',
  displayKey: 'name',
  source: profiles.ttAdapter(),
  templates: {
    header: '<div class="search-boarder nopadding"> <strong>Users</strong> </div>',
    empty: [
      '<div class="empty-message">',
      'unable to find any matches',
      '</div>'
    ].join('\n'),
    suggestion: function (data) { return templ.render(data); }
        }
},
{
  name: 'skill',
  displayKey: 'sname',
  source: skills.ttAdapter(),
  templates: {
    header: '<div class="search-boarder nopadding"> <strong>Skills</strong> </div>',
  empty: [
    '<div class="empty-message">',
      'unable to find any matches',
      '</div>'
  ].join('\n'),
  suggestion: function (data) { return templskill.render(data); }
        }
}
);
});