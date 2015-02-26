$(function() {
$('.custom').bind("ajax:success", function(){ alert('Name updated for '); });
});
<%=javascript_include_tag "best_in_place"%>
<%=javascript_include_tag "users"%>
<script>
	$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();

});
</script>
	<div class="col-md-4 whitesmoke-boarder no-padd">
	<div class="element-header text-center">
		<strong>In place editing</strong>
	</div>
		<%= best_in_place @user.profile,:firstname, :as => :input, :path => user_profile_path(@user,@user.profile), :cl%>
	</div>
	<%=javascript_include_tag "users"%>
;
