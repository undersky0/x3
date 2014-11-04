class ArealistCell < Cell::Rails

  def show

    @localfeeds = Localfeed.all
    render
  end
end
