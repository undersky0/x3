var CommentBox = React.createClass({
    getInitialState: function () {
        return { blog_comments: this.props.initialBlogComments,
                 blog_id: this.props.initialBlogID
        };
    },
    handleCommentSubmit: function ( formData, action ) {
        $.ajax({
            data: formData,
            url: action,
            type: "POST",
            dataType: "json",
            success: function ( data ) {
                this.setState({ blog_comments: this.state.blog_comments.concat(data) });
            }.bind(this),
            error: function (xhr, status, err) {
                console.error(action, status, err.toString());
            }.bind(this)
        });
    },

render: function () {

    return (
        <div className="col-md-12">
            <hr />
            <CommentForm blog_id={this.state.blog_id} onCommentSubmit={ this.handleCommentSubmit } />
            <hr />
            <BlogCommentsList blog_comments={ this.state.blog_comments } />
            <hr />
            </div>
            );
        }
    });

