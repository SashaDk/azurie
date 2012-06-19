class RssLinksController < ApplicationController
  before_filter :authenticate_user!, :except => :rss
  load_and_authorize_resource :except => :rss

  def index
    @rss_links = RssLink.top
    @new_link = RssLink.new
  end

  def create
    @new_link = RssLink.new(params[:rss_link])
    if @new_link.save
      redirect_to rss_links_path
    else
      @rss_links = RssLink.top
      render :index
    end
  end

  def update
    @link = RssLink.find(params[:id])
    @link.update_attributes(params[:rss_link])
    redirect_to rss_links_path
  end

  def destroy
    @rss_link = RssLink.find params[:id]
    @rss_link.destroy
    redirect_to rss_links_path
  end

  def rss
    @rss_links = params[:category] ? RssLink.category(params[:category]) : RssLink.all 
    @items = []
    @rss_links.map(&:items).map{|i| @items += i }
    @items.sort!{|x,y| y.instance_variable_get("@shares") <=> x.instance_variable_get("@shares") }
    @items = @items.delete_if {|i| i.instance_variable_get("@shares") == 0}
    render :layout => false # rss.rss.builder
  end
end
