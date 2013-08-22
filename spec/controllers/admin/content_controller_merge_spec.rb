 require 'spec_helper'



 describe Admin::ContentController do
   describe "Merge" do
      before :each do 
         Factory(:blog) if Blog.count == 0 
           @user = Factory(:user, 
               :login => 'admin', 
               :password => 'samepsw',
               :name => 'admin',
               :profile_id => 1,
               :state => 'active',
               :id => 1) 
           @user_na = Factory(:user, 
               :login => 'non-admin', 
               :password => 'samepsw',
               :name => 'non-admin',
               :profile_id => 2,
               :state => 'active',
               :id => 2) 
          @article_ref = Factory(:article, 
              :title => 'Article 1',
              :body => 'Article text 1', 
              :user_id => 1,
              :published => true) 
          @article_to = Factory(:article, 
              :title => 'Article 2',
              :body => 'Article text 2', 
              :user_id => 1,
              :published => true)
          @article_na = Factory(:article, 
              :title => 'Article 3',
              :body => 'Article text 3', 
              :user_id => 2,
              :published => true)
        request.session = {:user => @user.id} 
    end 

    describe "When articles are merged, the article id to be merged should be different from the current id" do
      it "should notify via flash that the id is wrong" do 
        post :merge, {:id => @article_ref.id, :merge_with => @article_ref.id} 
        response.should redirect_to "/admin/content/edit/#{@article_ref.id}" 
        flash[:error].should match (/The Article ID cannot be found or is not valid .+$/)
      end 
    end

    describe "When articles are merged, the article id to be merged should refer to an existing Article" do
      it "should notify via flash that the id is wrong" do 
        post :merge, {:id => @article_ref.id, :merge_with => 99 } 
        response.should redirect_to "/admin/content/edit/#{@article_ref.id}" 
        flash[:error].should match (/The Article ID cannot be found or is not valid .+$/)
      end 
    end

    describe "When articles are merged, the merged article should contain the text of both previous articles" do
      before do
          post :merge, {:id => @article_ref.id, :merge_with => @article_to.id }
      end
      it "be on the admin content edit page for Article 1" do 
          response.should redirect_to "/admin/content/edit/#{@article_ref.id}" 
      end 
      it "should notify via flash that the merge has been done" do 
          flash[:warning].should match (/^.+ has been merged with .+$/)
      end 
      it "The Title field should be Article 1" do 
          #Article.find(@article_ref.id).title.should match (/Article 1/)
          assigns(:article).title.should match ('Article 1') 
      end
      it "The Body should contain Article text 2" do 
          #Article.find(@article_ref.id).body.should match (/Article text 2/)
          assigns(:article).body.should match (/Article text 2/)
      end
   end

    describe "A non-admin cannot merge two articles" do
      before do
         request.session = {:user => @user_na.id} 
      end
      it "should notify via flash that the Article ID access is denied" do 
        post :edit, {:id => @article_ref.id} 
        response.should redirect_to "/admin/content" 
        flash[:error].should match (/Error, you are not allowed to perform this action/)
      end 
      #it "should not have the field Merge " do 
      #  post :edit, {:id => @article_na.id }
      # response.should redirect_to "/admin/content/edit/#{@article_na.id}" 
      #  it { should_not have_field("merge") }
      #end 
    end

  # main desc end
  end

# final end
end
