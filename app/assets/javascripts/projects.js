$(document).ready(function(){
$('#new_project').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'fa fa-check',
            invalid: 'fa fa-remove',
            validating: 'fa fa-refresh'
        },
        fields: {
            'project[name]': {
                message: 'Not valid',
                validators: {
                    notEmpty: {
                        message: 'Cannot be empty'
                    },
                    stringLength: {
                        min: 1,
                        max: 100,
                        message: 'Must be more than 1 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: 'The name can only consist of alphabetical, number and underscore'
                    }
                }
            },
           	'.tinymce': {
            	validators: {
            		notEmpty: {
            			message: 'Please describe your project'
            		},
            		stringLength: {
            			min: 30,
            			max: 5000,
            			message: 'Atleast 30 characters please'
            		}
            	}
            },
     }
    });
   });