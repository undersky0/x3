class NavigationController < ApplicationController
  before_filter :update_scribblestreams, :only => [:home, :refreshscribbles]
  before_filter :update_feed
  
  def home

  end

  def feeds
  end
  
  def promote
  @scribble = Scribble.find(params[:id])
  @scribble.promotes=@scribble.promotes+1
  @scribble.save
  render :text => "<div class='up'></div>"+@scribble.promotes.to_s+" likes"
  end
 
  def demotes
  @scribble = Scribble.find(params[:id])
  @scribble.demotes=@scribble.demotes+1
  @scribble.save
  render :text => "<div class='down'></div>"+@scribble.demotes.to_s+" dislikes"
  end
 
  def refreshscribbles
  render :partial => 'scribbles.html.erb', :locals => { :scribbles_streams => @scribbles_streams }
  end
  
  def refreshfeeds
    render :partial => 'feed.html.erb', :locals => { :feed_stream => @feed_stream}
  end
  
  def refreshcomments
    render :partial => 'comments.html.erb', :locals => {:comments_streams => @comments_streams}
  end
  
  protected
  
  def update_comments
    @comments_streams = Comment.order('created_at DESC').all
  end
  
  def update_scribblestreams
  @scribbles_streams = Scribble.order('created_at DESC').all
  end
  
  def update_feed
  @localfeed = Localfeed.find_by_city("Cardiff")
  @feed_stream = @localfeed.scribbles.order('created_at DESC').all
  end 
 

 
end
