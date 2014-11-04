$(function() {
    $('.datepicker').datetimepicker({
        pickTime: false
    });
});

$(function() {
	console.log("datetimepicker");
    $('.datetimepicker').datetimepicker({
    	sideBySide: true,
        pickSeconds: false,
        minuteStepping:15,
        icons: {
	        time: "fa fa-clock-o",
	        date: "fa fa-calendar",
	        up: "fa fa-arrow-up",
	        down: "fa fa-arrow-down"
    }
    });
});

$(function() {
    $('.timepicker').datetimepicker({
        pickDate: false,
        pickSeconds: false,
        minuteStepping:15,
        defaultDate: new Date(79, 1, 1, 1, 0, 0, 0),
        icons: {
	        time: "fa fa-clock-o",
	        up: "fa fa-arrow-up",
	        down: "fa fa-arrow-down"
    }
    });
});