require "rails_helper"

describe Optimadmin::ArticleCategoriesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when article category is valid" do
      it "redirects to index on normal save" do
        article_category = stub_valid_article_category

        post :create, commit: "Save", article_category: article_category.attributes

        expect(response).to redirect_to(article_categories_path)
        expect(flash[:notice]).to eq("Article category was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        article_category = stub_valid_article_category

        post :create, commit: "Save and continue editing", article_category: article_category.attributes

        expect(response).to redirect_to(edit_article_category_path(article_category))
        expect(flash[:notice]).to eq("Article category was successfully created.")
      end
    end

    context "when article category is invalid" do
      it "renders the edit template" do
        article_category = stub_invalid_article_category

        post :create, commit: "Save", article_category: article_category.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when article category is valid" do
      it "redirects to index on normal save" do
        article_category = stub_valid_article_category

        patch :update, id: article_category.id, commit: "Save", article_category: article_category.attributes

        expect(response).to redirect_to(article_categories_path)
        expect(flash[:notice]).to eq("Article category was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        article_category = stub_valid_article_category

        patch :update, id: article_category.id, commit: "Save and continue editing", article_category: article_category.attributes

        expect(response).to redirect_to(edit_article_category_path(article_category))
        expect(flash[:notice]).to eq("Article category was successfully updated.")
      end
    end

    context "when article category is invalid" do
      it "renders the edit template" do
        article_category = stub_invalid_article_category

        patch :update, id: article_category.id, commit: "Save", article_category: article_category.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  
  def stub_valid_article_category
    article_category = build_stubbed(:article_category)
    allow(ArticleCategory).to receive(:new).and_return(article_category)
    allow(article_category).to receive(:save).and_return(true)
    allow(ArticleCategory).to receive_message_chain(:friendly, :find).and_return(article_category)
    allow(article_category).to receive(:update).and_return(true)
    article_category
  end

  def stub_invalid_article_category
    article_category = build_stubbed(:article_category)
    allow(ArticleCategory).to receive(:new).and_return(article_category)
    allow(article_category).to receive(:save).and_return(false)
    allow(ArticleCategory).to receive_message_chain(:friendly, :find).and_return(article_category)
    allow(article_category).to receive(:update).and_return(false)
    article_category
  end
end

