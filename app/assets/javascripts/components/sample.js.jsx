var MessageBox = React.createClass({

    deleteMessage: function(message){
        var newMessages = _.without(this.state.messages, message);
        console.log(newMessages);
        this.setState({
            messages: newMessages
        });
    },


    handleCreate: function(message) {
      var name = this.refs.newMessage.getDOMNode().value;
        var comment = this.refs.newMessage.getDOMNode().value;

        $.ajax({

        });
    },

    handleAdd: function(e) {
    var newMessage = this.refs.newMessage.getDOMNode().value;
    console.log(this.refs.newMessage.getDOMNode().value);
        console.log(this.props.url);
    var newMessages = this.state.messages.concat([newMessage]);
    this.setState({
       messages: newMessages
    });
    },

    getInitialState: function(){
      return {
          isVisible: true,
          titleMessage: "Hello, world",
          messages: [
              'message1',
              'message2',
              'message3'
          ]
      }
    },

    render: function(){

        var inlineStyles = {
            display: this.state.isVisible ? 'block' : 'none'
        };

        var messages = this.state.messages.map(function(message){
           return <SubMessage message={message} onDelete={this.deleteMessage} />;
    }.bind(this));

        var subMessage = null;

        return (
            <div className = "row" style = {inlineStyles}>
            <h2>{this.props.titleMessage}</h2>
            <input ref = "newMessage" type = "text" />
            <button class="btn btn-primary" onClick={this.handleAdd}> Click me </button>
            {messages}
            </div>
        );
    }
});

var SubMessage = React.createClass({

    handleDelete: function(e){
       this.props.onDelete(this.props.message);
    },

    propTypes: function (){
      message: React.propTypes.string.isRequired
    },

    getDefaultProps: function(){
      return {
          message: "its good to see you"
      }
    },


   render: function(){
       return (
               <div>
         <small> {this.props.message} </small>
       <button onClick = {this.handleDelete} className="btn btn-danger">X</button>
                </div>
       );
   }
});

var message = "yo!";

var reactComponentsJSX = React.render(
    <MessageBox titleMessage={message}/>,
    document.getElementById('jsx')
)
