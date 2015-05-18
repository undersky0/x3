var CommentForm = React.createClass({

    handleSubmit: function ( event ) {
    event.preventDefault();

    var name = this.refs.name.getDOMNode().value.trim();
    var comment = this.refs.comment.getDOMNode().value.trim();

    // validate
    if (!name || !comment) {
        return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    var action = "/blog_posts/" + this.props.blog_id + "/blog_comments";
    this.props.onCommentSubmit( formData, action );

    // reset form
    this.refs.name.getDOMNode().value = "";
    this.refs.comment.getDOMNode().value = "";
},
render: function () {
    return (
        <div className="row">
            <div className="col-md-12 whitesmoke-boarder" style={{padding: '20px'}}>
            <form ref="form" className="form-inputs" action="/blog_posts/a/blog_comments" accept-charset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
                <p><input className="string form-control" ref="name" name="blog_comment[name]" placeholder="Your name" /></p>
                <p><textarea className="text form-control" ref="comment" name="blog_comment[comment]" placeholder="Say something..." /></p>
                <p><button className="btn btn-success" type="submit">Post comment</button></p>
            </form>
            </div>
        </div>
)
}
});