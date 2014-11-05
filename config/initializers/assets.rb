# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( search.js devise.css localfeeds.js 
bootstrap-modal/css/bootstrap-modal.css modals.js skills.css
bootstrap-modal/js/bootstrap-modalmanager.js
bootstrap/js/modal.js
bootstrap-modal/js/bootstrap-modal.js
fileinput.js
skillvalidator.js
moment/min/moment.min.js
moment/locale/en-gb.js
pickers.js
eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js
bootstrapvalidator/dist/js/bootstrapValidator.js
bootstrapvalidator/dist/js/language/en_US.js
eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css
bootstrapvalidator/dist/css/bootstrapValidator.css
fileinput.css
jquery.js
jquery.Jcrop.css
jquery.Jcrop.js
users.js
googlemaps.js
)
