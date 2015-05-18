var HelloWorld = React.createClass({displayName: "HelloWorld",
    render: function() {
        return (
            React.createElement("div", {className: "HelloWorld"}, 
        "Hello, world!"
        )
        );
    }
});

var ready = function () {
    React.renderComponent(
    React.createElement(HelloWorld, null),
        document.getElementById('comments')
    );
};

$(document).ready(ready);
