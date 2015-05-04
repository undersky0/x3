$(document).ready(function(){
$('#new_location').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'fa fa-check',
            invalid: 'fa fa-remove',
            validating: 'fa fa-refresh'
        },
        fields: {
            'location[google_address]': {
                message: 'Not valid',
                validators: {
                    notEmpty: {
                        message: 'First line is required and cannot be empty'
                    },
                    stringLength: {
                        min: 1,
                        max: 100,
                        message: 'Must be more than 1 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_\s]+$/,
                        message: 'The name can only consist of alphabetical, number and underscore'
                    }
                }
            },
           	'location[postcode]': {
            	validators: {
            		notEmpty: {
            			message: 'Please enter your postcode or select a location on the map'
            		},
            		stringLength: {
            			min: 3,
            			max: 30,
            			message: 'Atleast 3 characters please'
            		}
            	}
            },
             'location[city]': {
            	validators: {
            		notEmpty: {
            			message: 'Please enter your city or select a location on the map'
            		},
            		stringLength: {
            			min: 3,
            			max: 30,
            			message: 'Atleast 3 characters please'
            		}
            	}
            },
     }
    });
   });