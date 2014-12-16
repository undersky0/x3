$(function() {
	    $('#r1').hide(); 
   	$('.fileinput').fileinput();
    
    $('#level').change(function(){
        if($('#level').val() != 'All Welcome') {
            $('#r1').show(); 
        } else {
            $('#r1').hide(); 
        } 
        });
	console.log("skill val loaded");
    $('#new_skill').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'fa fa-check',
            invalid: 'fa fa-remove',
            validating: 'fa fa-refresh'
        },
        fields: {
            'skill[name]': {
                message: 'The name is not valid',
                validators: {
                    notEmpty: {
                        message: 'The name is required and cannot be empty'
                    },
                    stringLength: {
                        min: 2,
                        max: 30,
                        message: 'The username must be more than 6 and less than 30 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: 'The name can only consist of alphabetical, number and underscore'
                    }
                }
            },
            'skill[description]': {
                validators: {
                    notEmpty: {
                        message: 'Description is required and cannot be empty'
                    },
                    stringLength: {
                        min: 30,
                        max: 4500,
                        message: 'The description should be atleast a sentence or two'
                    }
                }
            },
            'skill[teachers_title]': {
            	validators: {
            		notEmpty: {
            			message: 'Please enter your title'
            		},
            		stringLength: {
            			min: 2,
            			max: 30,
            			message: 'Atleast 2 letters please'
            		}
            	}
            },
            'skill[start_date]': {
            	validators: {
            		notEmpty: {
            			message: 'Please enter date and time'
            		}
            	}
            },
            'skill[activity_duration]': {
            	validators:{
            		 notEmpty: {
            			message: 'Please enter date and time'
            		},
            		time: {
                        format: 'h:m',
                        message: 'Please select the duration'
                    }
            	}
            },
            'skill[min_students]': {
            	validators:{
            		notEmpty: {
            			message: 'Please enter the minumum number of students'
            		},
            		between: {
                        min: 1,
                        max: 1000,
                        message: 'Enter minimum number of students'
                    }
            	}
            },
            'skill[max_students]': {
            	validators:{
            		notEmpty: {
            			message: 'Please enter the maximum number of students'
            		},
            		between: {
                        min: 1,
                        max: 1000,
                        message: 'Enter maximum number of students'
                    }
            	}
            },
            'skill[price]': {
            	validators:{
            		notEmpty: {
            			message: 'Please enter price, 0 if its free'
            		},
            		between: {
                        min: 0,
                        max: 1000,
                        message: 'Please enter price'
                    }
            	}
            }
        }
    });
    console.log("skillval done");
});
