class RssLinksController < ApplicationController
  def index
    @rss_links = RssLink.all
    @new_link = RssLink.new
  end

  def create
    RssLink.create!(params[:rss_link])
    redirect_to rss_links_path
  end

  def destroy
    @rss_link = RssLink.find params[:id]
    @rss_link.destroy
    redirect_to rss_links_path
  end

  def rss

  end
end
