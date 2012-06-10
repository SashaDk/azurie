class RssLinksController < ApplicationController
  before_filter :authenticate_user!, :except => :rss
  load_and_authorize_resource :except => :rss

  def index
    @rss_links = RssLink.top
    @new_link = RssLink.new
  end

  def create
    @rss_links = RssLink.top
    @new_link = RssLink.new(params[:rss_link])
    if @new_link.save
      redirect_to rss_links_path
    else
      render :index
    end
  end

  def destroy
    @rss_link = RssLink.find params[:id]
    @rss_link.destroy
    redirect_to rss_links_path
  end

  def rss
    @items = []
    RssLink.all.map(&:items).map{|i| @items += i }
    @items.sort!{|x,y| y.instance_variable_get("@shares") <=> x.instance_variable_get("@shares") }
    render :layout => false # rss.rss.builder
  end
end
