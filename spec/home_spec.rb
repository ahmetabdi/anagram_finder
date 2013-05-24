require 'rspec'
require 'spec_helper'

describe HomeController, :type => :controller do

  describe "GET #index" do
    before(:each) do
      @finder = AnagramFinder.new("#{Rails.root}/spec/fixtures/test.txt", "center")
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

    it "should find the anagrams inside a file" do
      @finder.results.should == ["center", "centre", "recent"]
    end

    it "should return the anagram" do
      @finder.anagram.should == "center"
    end

  end

  describe "POST /upload" do
    before(:each) do
      @txt = fixture_file_upload('/test.txt', 'text/plain')
      @jpg = fixture_file_upload('/picture.jpg', 'image/jpeg')
    end

    it "should be able to upload file" do
      post :upload, :uploaded_file => @txt
      response.should render_template :index
    end

    it "should only allow you to upload a .txt file" do
      post :upload, :uploaded_file => @jpg
      flash[:error].should eql("Only .txt files are allowed")
      response.should render_template :index
    end

    it "shouldn't allow you to upload an empty file" do
      post :upload
      flash[:error].should eql("Please choose a file to upload")
      response.should render_template :index
    end

  end

end