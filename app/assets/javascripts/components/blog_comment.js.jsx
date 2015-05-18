var Blog_Comment = React.createClass({
    render: function() {
    return (
        <div className="row">
        <div className="col-md-12">
            <h4>{ this.props.blog_comment.name }
            <small className="pull-right"> { this.props.blog_comment.created_at}</small></h4>
            <small classNmae="longtext">{ this.props.blog_comment.comment }</small>
            <hr/>
        </div>
            </div>
);
}
});