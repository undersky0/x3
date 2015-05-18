//name the function
var BlogCommentsList = React.createClass({

    render: function() {
        //console.log(blog_comments);
        var b = this.props.blog_comments.sort(function(a, b) {
            a = new Date(a.created_at);
            b = new Date(b.created_at);
            return a>b ? -1 : a<b ? 1 : 0;
        });
        var blog_comments = b.map(function(blog_comment) {
            return <Blog_Comment key={blog_comment.id} blog_comment={blog_comment} />;
        });

        return (
            <div className= "row whitesmoke-boarder">
                <div className = "col-md-12" style={{padding: '20px 20px 0px 20px'}}>
                    {blog_comments}
                </div>
            </div>
        )
    }
});