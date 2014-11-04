$ ->
  $('#group_search').typeahead
    name: "group"
    remote: "/groups/autocomplete?query=%QUERY"
    

jQuery ->
  $('.best_in_place').best_in_place()
